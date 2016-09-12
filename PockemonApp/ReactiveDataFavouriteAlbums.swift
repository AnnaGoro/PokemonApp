//
//  ReactiveDataFavouriteAlbums.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 07.09.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReactiveDataFavouriteAlbums {
       
    static var favouritesCheck : [Int : Variable<Bool>] = [:]
    
    static func populateAlbums(albums: [Album]) {
        
        albums.forEach { (album) in
            
            guard favouritesCheck[album.id!] == nil else { return }
            
            self.favouritesCheck[album.id!] = Variable(false)
        }
        
    }
    
    static func setLikeStatus(album: Album, status: Bool) {
        favouritesCheck[album.id!]?.value = status
    }
        
        
}
    
