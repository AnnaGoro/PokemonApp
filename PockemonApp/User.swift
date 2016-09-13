//
//  Pokemon.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper



struct User : Mappable, Equatable {
    
    
    private(set) var userId : Int?
    private(set) var name : String?
    
    
    init? (_ map : Map) {
        
        
    }
    
    
    init () {
        
        
        
    }
    
    mutating func mapping (map : Map) {
        
        userId <- map["id"]
        name <- map["name"]
        
    }
    
}

func ==(lhs: User, rhs: User) -> Bool {
    
    return lhs.userId == rhs.userId &&
        lhs.name == rhs.name
}
