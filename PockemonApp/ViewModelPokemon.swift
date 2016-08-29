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

    var name: Variable <String> = Variable( "" )
    var weight : Variable <String> = Variable( "" )
    
    private let apiService = ApiService()
    private let apiServiceGetPokemons = ApiServiceGetPokemons()
    private let bag = DisposeBag()
    
    
    
    var observableApiGetPokemons : Observable <[String]>? {
        
        didSet {
            guard let observable = observableApiGetPokemons else { return }
            
            observable
                .throttle(0.4, scheduler: MainScheduler.instance)
                .flatMap{ (pokemons : [String]) -> Observable <[String]?> in
                    
                    if  pokemons.isEmpty {
                        print ()
                            return self.apiService.getPokemonsUrlsNames(10)}
            
                    
                    /*
                    } else if !pokemons.isEmpty {
                        observable.map {pokemons in return Pokemon(pokemons)
                        
                        for element in pokemons {
                            return self.apiServiceGetPokemons.getPokemons(element.)
                            }
                        }
                    
                        }
                        
                    */
                     else {
                        
                        return Observable.just(nil)
                    
                    }
                    
                  
                }
                .subscribe(
                    onNext: { pokemons in
                        for value in pokemons! {
                        self.name.value = value
                      
                        }
                    },
                    
                    onError: { pokemon in
                        
                        
                    }
                    
                ).addDisposableTo(bag)
        }
        
    }
    
    



}