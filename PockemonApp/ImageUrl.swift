//
//  ImageUrl.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 30.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper

class ImageUrl : Mappable{
    
    var iUrl : String?
    
    init (iUrl : String) {
    
        self.iUrl = iUrl
        
    }
    
    required init?(_ map : Map) {
        
    }
    
    func mapping (map : Map){
        iUrl <- map["front_default"]
    }
}