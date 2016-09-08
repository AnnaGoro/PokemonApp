//
//  AbilityName.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 30.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper


func ==(lhs: Album, rhs: Album) -> Bool {
    return lhs.id == rhs.id
}

struct Album : Mappable, Equatable{
    
   
    private(set) var id : Int?
    private(set) var userId : Int?
    private(set) var title : String?

    
    init () {
    
    }
    
     init?(_ map : Map) {
        
    }
    
   mutating func mapping (map : Map){
    
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
    }
    
    
    
}

