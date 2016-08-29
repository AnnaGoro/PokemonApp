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
        
        let pokemon = Pokemon()
        
        return Alamofire.request(.POST, self.url)
            .rx_responseData().shareReplayLatestWhileConnected()
            .map { (res: NSHTTPURLResponse, data: AnyObject) -> [Pokemon]? in
                
                guard let name = data["name"] as? String,
                    let weight = data["weight"] as? String else{
                        
                        return nil
                        
                }
                pokemon.name = name
                pokemon.weight = weight
                self.pokemons.append(pokemon)
                
                
                
                return self.pokemons
        }
        
        
    }
    
    
}
