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
    
    func getPokemons(url : String, count : Int) -> Observable <Pokemon?>  {
        print ("getPokemons")
     // return Observable.create{ observer in
        print("ololo")
   
            
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
                //print(weight)
                
                self.pokemon.name = name
                //self.pokemon.weight = weight
                print(self.pokemon.name)
                
               
               
                print(self.pokemon.weight)
                self.pokemons.append(self.pokemon)
                
                
       
        
            return self.pokemon

        }
       // return self.pokemons
            
            //observer.onNext(pokemonResponse)
            //observer.onCompleted()
       }
        
       // }
        //return NopDisposable.instance
    }
    
    

