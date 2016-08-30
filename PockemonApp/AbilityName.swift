//
//  AbilityName.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 30.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper

class AbilityName : Mappable {
    
    var name : String?
    
    required init?(_ map : Map) {
        
    }
    
    func mapping (map : Map){
        name <- map["name"]
    }
}