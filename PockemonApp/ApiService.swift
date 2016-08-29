//
//  ApiService.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift

class ApiService {
    
    private let url = "http://pokeapi.co/api/v2/pokemon"
    
    var pokemonUrlsNames = [PokemonUrlsNames]()

    func getPokemonsUrlsNames() -> Observable <[PokemonUrlsNames]?>  {
        
        let pokemonUrlName = PokemonUrlsNames()
        
            return Alamofire.request(.POST, self.url)
                .rx_responseData().shareReplayLatestWhileConnected()
                .map { (res: NSHTTPURLResponse, data: AnyObject) -> [PokemonUrlsNames]? in
                    
                    if let results = data["results"] as? [[String: String]] {
                        for value in results {
                            pokemonUrlName.url = value["url"] as String!
                            pokemonUrlName.name = value["name"] as String!
                           self.pokemonUrlsNames.append(pokemonUrlName)
                        }
                        
                    } else {
                            
                            return nil
                    }
                    
                    return self.pokemonUrlsNames
            }
            

    
    
    
    }










}
