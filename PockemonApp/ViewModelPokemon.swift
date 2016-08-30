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

   // private let pokemon: Pokemon
    
    var modelName: Variable <String> = Variable( "" )
    var modelWeight: Variable <String> = Variable( "" )
    
    private let apiService = ApiService()
    private let apiServiceGetPokemons = ApiServiceGetPokemons()
   // private let bag = DisposeBag()
    
    var pokemons: Observable<[Pokemon]?>?
     /*
    init (pokemon : Pokemon) {
    
        self.pokemon = pokemon
    
        modelName = BehaviorSubject<String>(value: pokemon.name!)
        modelName.subscribeNext { (name) in
        pokemon.name = name
        }.addDisposableTo(bag)
        
        
        
        modelWeight = BehaviorSubject<String>(value: pokemon.weight!)
        modelWeight.subscribeNext { (weight) in
            pokemon.weight = weight
            }.addDisposableTo(bag)
    }
    
 
    init() {
        // ...
        
        self.pokemons = self.apiService.getPokemonsUrlsNames(20)
            // Get the countries corresponding to the alpha codes
            // specified in the `borders` property
            .flatMap { url in
                self.apiServiceGetPokemons.getPokemons(url!, count: 20)
            }
            // Catch any error and print it in the console
            .catchError { error in
                print("Error: \(error)")
                return Observable.just([])
            }
            // Transform the resulting countries into [Border]
           // .map { countries in
                //countries.map { (name: $0.name, nativeName: $0.nativeName) }
           // }
            // Make sure events are delivered in the main thread
            .observeOn(MainScheduler.instance)
            // Make sure multiple subscriptions share the side effects
            .shareReplay(1)
    }

    */
    
    var observableApiGetPokemons : Observable <[String]?>? {
        
        didSet {
 
            if let value = self.apiService.getPokemonsUrlsNames(20) {
                self.pokemons = value
                // Get the countries corresponding to the alpha codes
                // specified in the `borders` property
                .flatMap { url in
                    self.apiServiceGetPokemons.getPokemons(url!, count: 20)
                }
                // Catch any error and print it in the console
                .catchError { error in
                    print("Error: \(error)")
                    return Observable.just([])
                }
                // Transform the resulting countries into [Border]
                .map { pokemons in
                pokemons.map { (modelName: $0, modelWeight: $0) }
                 }
                // Make sure events are delivered in the main thread
                .observeOn(MainScheduler.instance)
                .subscribe(
                    onNext: { pokemons in
                        for value in pokemons! {
                            modelName.value = value
                            
                        }
                    },
                    
                    onError: { pokemon in
                        
                        
                    }
                    
                )
            
        }
                // Make sure multiple subscriptions share the side effects
        


    }
    }
}



