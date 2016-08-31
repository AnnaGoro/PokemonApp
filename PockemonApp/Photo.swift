//
//  Type.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 30.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct Photo : Mappable {
    
    
    private(set) var id : Int?
    private(set) var url : String?
    private(set) var thumbnailUrl : String?
    private(set) var albumId : Int?
    
        init? (_ map : Map) {
        
    }
    
    
    mutating func mapping (map : Map){
        id <- map["id"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
        albumId <- map["albumId"]
    }
}

