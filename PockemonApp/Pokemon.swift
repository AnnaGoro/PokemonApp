//
//  Pokemon.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper

class Pokemon : Mappable {

    var id : Int?
    var name : String?
    var weight : String?
    var height : String?
    var types : [Type]?
    var abilities : [Ability]?
    var imageUrl : ImageUrl?
    var pokemonUrl : String?
    
    init (id : Int, name : String, imageUrl : ImageUrl) {
    
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        
    }
    
    required init? (_ map : Map) {
    
    
    }
    
    func mapping (map : Map) {
        
        id <- map["id"]
        name <- map["name"]
        weight <- map["weight"]
        height <- map["height"]
        types <- map["types"]
        abilities <- map["abilities"]
        imageUrl <- map["sprites"]
        pokemonUrl <- map["url"]
    
    }

}


