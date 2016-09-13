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
    
    var id : Int?
    var url : String?
    var thumbnailUrl : String?
    var albumId : Int?
    var title : String?
    
    init? (_ map : Map) {
        
    }
    
    
    mutating func mapping (map : Map){
        id <- map["id"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
        albumId <- map["albumId"]
        title <- map["title"]
    }
}

