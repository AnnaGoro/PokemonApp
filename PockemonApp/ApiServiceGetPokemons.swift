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
     
        
        
        //for url in urls {
           // print ("request")
            
           return Alamofire.request(.GET, url)
            .rx_responseJSON()
            .map { (res: NSHTTPURLResponse, data: AnyObject) -> Pokemon? in
                print ("map")
                guard let name = data["name"] as? String,
                    let weight = data["weight"] as? String  else{
                       print("NNNNNNNNNNNIIIIIILLLLLLLLLLLLL")
                        return nil
                        
                }
                
                print("this is maaaaap")
                print(weight)
                print(self.pokemon.name = name)
                
                self.pokemon.name = name
                self.pokemon.weight = weight
                
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
    
    

