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

class ApiServiceGetPokemons {
    
    let url = "http://pokeapi.co/api/v2/pokemon"
    
    var pokemons = [Pokemon]()
    
    func getPokemons() -> Observable <[Pokemon]?>  {
        
        let pokemonUrlName = Pokemon()
        
        return Alamofire.request(.POST, self.url)
            .rx_responseData().shareReplayLatestWhileConnected()
            .map { (res: NSHTTPURLResponse, data: AnyObject) -> [Pokemon]? in
                
                if let results = data["results"] as? [[String: String]] {
                    for value in results {
                        pokemonUrlName.url = value["url"] as String!
                        pokemonUrlName.name = value["name"] as String!
                        self.pokemons.append(pokemon)
                    }
                    
                } else {
                    
                    return nil
                }
                
                return self.pokemonUrlsNames
        }
        
        
        
        
        
}



