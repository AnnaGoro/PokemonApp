//
//  Pokemon.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct User : Mappable {

    //private(set)
    var userId : Int?
    private(set) var name : String?
    
    
    init? (_ map : Map) {
    
    
    }
    
    
    init () {
    
    
    
    }
    
    mutating func mapping (map : Map) {
        
        userId <- map["userId"]
        name <- map["name"]
        
    }

}


