//
//  ViewModelPokemon.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class ViewModelPokemon {
       
   // private let apiService = ApiService()
    private let apiServiceGetPokemons = ApiServiceGetPokemons()
       
    var pokemons: Observable<Pokemon>?
    
    
 /*
    
    func observableApiGetPokemons () ->  Observable<[Pokemon]?>? {
        
        var pokemons: Observable<[Pokemon]?>?
        var urlsArr : Observable<[String]?>?
        //var urls : [String]?
        
        print("Trololo")
        if let value = self.apiService.getPokemonsUrlsNames(20) {
             urlsArr = value
               // .map{urls -> [String]}
                let urlsString = urlsArr
                    .map{ return (arrayLiteral: $0.toArray())
                }
                pokemons = urlsString.flatMap { urls in
                    for url in urls {
                        self.apiServiceGetPokemons.getPokemons(url, count: 20)
                    
                    }
                    }!
            
            
            
                //print(pokemons)
        return pokemons
        }
    }

     */
        
        init () {
    
        if let value = self.apiServiceGetPokemons.getPokemonsUrlsNames(20) {
            self.pokemons = value
                .flatMap { url in
                   
                    self.apiServiceGetPokemons.getPokemon(url!)
                }
                .observeOn(MainScheduler.instance)
        }
        
    }

 
   
/*
    var observableApiGetPokemons : Observable <[Pokemon]?>? {
       
        didSet {
             print("Trololo")
            if let value = self.apiService.getPokemonsUrlsNames(20) {
                self.pokemons = value
                    
                    .flatMap { url in
                        self.apiServiceGetPokemons.getPokemons(url!, count: 20)
                    }
                    
                    .catchError { error in
                        print("Error: \(error)")
                        return Observable.just([])
                    }
                    
                    .observeOn(MainScheduler.instance)
            }
            
        }
    }
 */

    
    
    
    
    
}


