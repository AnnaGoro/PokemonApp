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
    var pokemon = Pokemon()
    
 /*
    func getPokemonsFor (urls : [String]) -> Observable <[Pokemon]?> {
    return Observable.create{ observer in
        
        for url in urls {
           var pokemon1 = self.getPokemons(url)
            .map{ (pokemon1) -> Pokemon? in
                self.pokemon = pokemon1!
                 return pokemon1
            }
           self.pokemons.append(pokemon1)
    
    }
        observer.onNext(pokemon)
        observer.onCompleted()
        }
        
        
        return NopDisposable.instance
    }
    */
    
    
    
    
    func getPokemons(url : String) -> Observable <Pokemon?>  {
        
     // return Observable.create{ observer in
      
   
            
           return Alamofire.request(.GET, url)
            .rx_responseJSON()
            .map { (res: NSHTTPURLResponse, data: AnyObject) -> Pokemon? in
         
                guard let name = data["name"] as? String else{
                           return nil
                }
                
                if let id = data["id"] as? Int {
                    self.pokemon.id = id
                    print(id)
                    
                }

                if let weight = data["weight"] as? String {
                     self.pokemon.weight = weight
                        print(weight)

                }
                
                print(name)
              
                
                self.pokemon.name = name
                //self.pokemon.weight = weight
                print(self.pokemon.name)
                
                print(self.pokemon.weight)
                
            return self.pokemon

        }
       // return self.pokemons
            
            //observer.onNext(pokemonResponse)
            //observer.onCompleted()
       }
        
       // }
        //return NopDisposable.instance
    }
    
    

