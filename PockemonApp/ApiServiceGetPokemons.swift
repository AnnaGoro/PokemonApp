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
      
    var pokemons = [Pokemon]()
    
    
    func getPokemons(urls : [String], count : Int) -> Observable <[Pokemon]?>  {
      return Observable.create{ observer in
        
      let pokemon = Pokemon()
        for url in urls{
        
       _ = Alamofire.request(.GET, url)
            .rx_responseData().shareReplayLatestWhileConnected()
            .map { (res: NSHTTPURLResponse, data: AnyObject) -> [Pokemon]? in
                
                guard let name = data["name"] as? String,
                    let weight = data["weight"] as? String else{
                      
                        return nil
                        
                }
                
                print(pokemon.name = name)
                
                pokemon.name = name
                pokemon.weight = weight
                
                self.pokemons.append(pokemon)
                
                return self.pokemons
        }
        
            

        }
        
        observer.on(.Next(self.pokemons))
        
        observer.on(.Completed)
        
        return NopDisposable.instance
    }
      
    }
}

