//
//  Sections.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 13.09.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionOfData {
    
    var header: String
    var items: [Item]
    
    
}

extension SectionOfData : AnimatableSectionModelType {
    
    typealias Item = ViewModelCell
    
    var identity: String {
        return header
    }
    
    init(original: SectionOfData, items: [Item]) {
        
        self = original
        self.items = items
    }
}





