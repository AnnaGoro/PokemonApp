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
    
    var modelName: Variable <String> = Variable( "" )
    var modelWeight: Variable <String> = Variable( "" )
    
    private let apiService = ApiService()
    private let apiServiceGetPokemons = ApiServiceGetPokemons()
       
    var pokemons: Observable<[Pokemon]?>?
    
    var observableApiGetPokemons : Observable <[Pokemon]?>? {
        
        didSet {
            
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
}



