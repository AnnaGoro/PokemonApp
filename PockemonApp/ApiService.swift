//
//  ApiService.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift

class ApiService {
    
    private let apiServiceGetPokemons = ApiServiceGetPokemons()
    
    func getPokemonsFromAllRacs(limit: Int) -> Observable<[Pokemon]>{
        
        return apiServiceGetPokemons.getPokemonsUrlsNames(limit)
            .flatMapLatest{ (urls : [PokemonUrlsNames]) -> Observable<[Pokemon]> in
                
                return urls.map{ (url : PokemonUrlsNames) -> Observable<Pokemon> in
                    return self.apiServiceGetPokemons.getPokemon(url.url!)
                    }
                    .combineLatest { (pokemons : [Pokemon]) -> [Pokemon] in
                        return pokemons
                }
                
            }.shareReplayLatestWhileConnected()
        
    }
    
    
    func getPokemonsForPreview (limit: Int) -> Observable<[Pokemon]>{
        
        return apiServiceGetPokemons.getPokemonsUrlsNames(limit)
            
            .flatMapLatest({ (pokemonUrlNameArray : [PokemonUrlsNames]) -> Observable<[Pokemon]> in
                
                return Observable.of(pokemonUrlNameArray.map{ (pokemonUrlName : PokemonUrlsNames) -> Pokemon in
                    
                    let data: [String] = pokemonUrlName.url!.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "/"))
                    
                    let index = Int(data[6])
                 
                    print(index)
                    
                    let url = "http://assets.pokemon.com/assets/cms2/img/pokedex/full/\(index!).png"
                    
                    print(url)
                    
                    return Pokemon(id : index!, name : pokemonUrlName.name!, imageUrl : ImageUrl(iUrl: url))
                    
                    }
                )
            })
    }
    
 }
