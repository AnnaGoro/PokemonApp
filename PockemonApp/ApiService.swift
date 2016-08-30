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
        
        let limit = limit > 720 ? 720 : limit
        
        return apiServiceGetPokemons.getPokemonsUrlsNames(limit)
            .flatMapLatest{ urls -> Observable<[Pokemon]> in
                
                return urls.map{ url -> Observable<Pokemon> in
                    return self.apiServiceGetPokemons.getPokemon(url)
                    }
                    .combineLatest { pokemons -> [Pokemon] in
                        return pokemons
                }                
                
        }
        
    }
    
    
    
    /*
     
     var textRange = currentURL.lowercaseString.rangeOfString("access_token".lowercaseString)
     
     if textRange != nil {
     
     var data: [String] = currentURL.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "=&"))
     user["access_token"] = data[1]
     user["expires_in"] = data[3]
     user["user_id"] = data[5]
     
     
     */
    
}
