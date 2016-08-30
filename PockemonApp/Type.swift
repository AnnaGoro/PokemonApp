//
//  Type.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 30.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper


class Type : Mappable{
    
    var type : TypeName?
    
    required init?(_ map : Map) {
        
    }
    
    
    func mapping (map : Map){
        type <- map["type"]
    }
}

