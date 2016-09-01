//
//  viewModelAlbumsList.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModelAlbumsList {

    var albums : Variable<[Album]> = Variable([])
    var user : Variable <User> = Variable(User())
    var album : Variable <Album> = Variable (Album())
    
    private let apiServiceGet = ApiServiceGet()
    private let bag = DisposeBag()
    
/*
     
     return apiServiceGetPokemons.getPokemonsUrlsNames(limit)
        .flatMapLatest{ (urls : [String]) -> Observable<[Pokemon]> in
            return urls.map{ (url : String) -> Observable<Pokemon> in
            return self.apiServiceGetPokemons.getPokemon(url)
            }
        .combineLatest { (pokemons : [Pokemon]) -> [Pokemon] in
                    return pokemons
        }
     
     }.shareReplayLatestWhileConnected()
     
 
 */
    
    
    init() {
    
        apiServiceGet.getAlbums().subscribe(
            
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
             }
            ).addDisposableTo(bag)
       
    }
   
    
}