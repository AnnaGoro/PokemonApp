//
//  SectionsPhoto.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 13.09.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionOfPhotos {
    
    var header: String
    var items: [Item]    
    
}

extension SectionOfPhotos : AnimatableSectionModelType {
    
    typealias Item = Photo
    
    var identity: String {
        return header
    }
    
    init(original: SectionOfPhotos, items: [Item]) {
        
        self = original
        self.items = items
    }
}

