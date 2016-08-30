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
    
    var image : String?
    
    
    required init?(_ map : Map) {
        
    }
    
    func mapping (map : Map){
        image <- map["front_default"]
    }
}