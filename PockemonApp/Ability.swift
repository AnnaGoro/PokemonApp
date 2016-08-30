//
//  Ability.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 30.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper

class Ability : Mappable {
    
    var abilityName : AbilityName?
    
    required init?(_ map : Map) {
        
    }
    
    
    func mapping (map : Map){
        abilityName <- map["ability"]
    }
}



