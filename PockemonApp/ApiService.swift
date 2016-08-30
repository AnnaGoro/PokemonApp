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
    
    private let url = "http://pokeapi.co/api/v2/pokemon"
    
    var pokemonUrlsNames : String?

    func getPokemonsUrlsNames(count : Int) -> Observable <String?>?  {
        print("getPokemonsUrlsNames")
    
        let parameters = [
            "limit": String(count)]
       
        
        return Alamofire.request(.GET, self.url, parameters: parameters)
            .rx_responseJSON().shareReplayLatestWhileConnected()
            .map { (res: NSHTTPURLResponse, data: AnyObject) -> String? in
                
                if let results = data["results"] as? [[String: String]] {
                    for value in results {
                        let a = value["url"] as String!
                        
                        print(a)
                        
                        self.pokemonUrlsNames = a
                    }
                    
                } else {
                    
                    return nil
                }
                
                return self.pokemonUrlsNames
        }
        
    }

}
