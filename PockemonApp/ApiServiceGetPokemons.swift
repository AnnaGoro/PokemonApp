//
//  ApiServiceGetPokemons.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift

import AlamofireObjectMapper

class ApiServiceGetPokemons {
    
    private let url = "http://pokeapi.co/api/v2/pokemon"
    
    func getPokemon(url : String) -> Observable<Pokemon> {
        
        return Observable.create{ observer in
            
            Alamofire.request(.GET, url)
                .responseObject{ (response: Response<Pokemon, NSError>) in
                    
                    guard let pokemonResponse = response.result.value else {
                        observer.onError(response.result.error!)
                        return
                    }
                    
                    observer.onNext(pokemonResponse)
                    observer.onCompleted()
            }
            
            return NopDisposable.instance
        }
    }
       
    
    func getPokemonsUrlsNames(count : Int) -> Observable <[PokemonUrlsNames]>  {
        
        let pokemonUrlName  = PokemonUrlsNames()
        var pokemonUrlNameArray = [PokemonUrlsNames]()
        
        
        let parameters = ["limit": String(count)]
        
        return Alamofire.request(.GET, self.url, parameters: parameters)
            .rx_responseJSON().shareReplayLatestWhileConnected()
            .map { (res: NSHTTPURLResponse, data: AnyObject) -> [PokemonUrlsNames] in
                
               
                if let results = data["results"] as? [[String: String]] {
                    for value in results {
                        let url = value["url"] as String!
                        let name = value["name"]
                        
                        pokemonUrlName.url = url
                        pokemonUrlName.name = name
                        pokemonUrlNameArray.append(pokemonUrlName)
                    }
                    
                } else {
                    
                    return []
                }
                
                return pokemonUrlNameArray
            }
    }
    
    
}

