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
    
    var pokemonUrlsNames = [String]()

    func getPokemonsUrlsNames(count : Int) -> Observable <[String]?>  {
        
        let parameters = [
            "limit": String(count)]

        let pokemonUrlName = PokemonUrlsNames()
        
            return Alamofire.request(.GET, self.url, parameters: parameters)
                .rx_responseData().shareReplayLatestWhileConnected()
                .map { (res: NSHTTPURLResponse, data: AnyObject) -> [String]? in
                    
                    if let results = data["results"] as? [[String: String]] {
                        for value in results {
                            pokemonUrlName.url = value["url"] as String!
                                                    
                            print(pokemonUrlName)
                            
                            self.pokemonUrlsNames.append(pokemonUrlName.url!)
                        }
                        
                    } else {
                            
                            return nil
                    }
                    
                    
                    return self.pokemonUrlsNames
            }
            

    
    
    
    }










}
