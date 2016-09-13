//
//  Type.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 30.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources


struct Photo : Mappable {
    
   private(set) var id : Int?
   private(set) var url : String?
   private(set) var thumbnailUrl : String?
   private(set) var albumId : Int?
   private(set) var title : String?
    
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


extension Photo : Hashable, IdentifiableType, Equatable  {
    
    
    var identity: Photo {
        
        return self
        
    }

    
    var hashValue : Int {
        get {
            return self.id!.hashValue + self.url!.hashValue
        }
    }
    
    
}

func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.id == rhs.id &&
        lhs.url == rhs.url
}





