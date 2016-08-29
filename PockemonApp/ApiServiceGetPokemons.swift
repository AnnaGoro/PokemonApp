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

struct ApiServiceGetPokemons {
    
    private let apiService = ApiService()
    private let bag = DisposeBag()
    
    var observableApiGetPokemons : Observable <[PokemonUrlsNames]>? {
        
        didSet {
            guard let observable = observableApiGetPokemons else { return }
            
            observable
                .throttle(0.4, scheduler: MainScheduler.instance)
                .flatMap{ (pokemons : [PokemonUrlsNames]) -> Observable <[PokemonUrlsNames]?> in
                    
                    guard pokemons != nil else {
                        
                        return Observable.just()
                        
                    }
                    
                    return self.apiService.getPokemonsUrlsNames()
                }
                .subscribe(
                    onNext: { pokemon in
                        
                        getPokemons(pokemon[].url)
                    },
                    onError: { pokemon in
                        
                        
                    }
                    
                ).addDisposableTo(bag)
        }
        
    }
    
    
    
    var pokemons = [Pokemon]()
    
    func getPokemons(url : String) -> Observable <[Pokemon]?>  {
        
        let pokemon = Pokemon()
        
        return Alamofire.request(.POST, url)
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
