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
    
//    
//    static func getFavouriteAlbums (albums : [Album], index : Int, checkboolSwitch : Bool) {
//        
//        apiService.recieveFavouriteAlbums(albums, index: index, checkBoolSwitch: checkboolSwitch)
//        
//        apiService.favouriteAlbums.asObservable().subscribeNext { (albums : [Album]) in
//            
//            self.favouriteAlbums.value = albums
//            
//            }.addDisposableTo(DisposeBag())
//        
//    }
//   
//    
//    
//    static func addFavouriteAlbum (album : Album) {
//        
//        if  !(self.favouriteAlbums.value.contains(album)){
//            
//            self.favouriteAlbums.value.append(album)
//            
//        }
//        
//        
//    }
//    
//    static func addOrDeleteFavouriteAlbum(index : Int, checkBoolSwitch : Bool){
//        
//        
//        if !checkBoolSwitch {
//            
//            guard favouriteAlbums.value.count > index else { return }
//            
//            deleteUnFavouriteAlbum(favouriteAlbums.value[index])
//            
//        }else {
//            
//            addFavouriteAlbum(albums.value[index])
//            
//        }
//        
//    }
//    
//    
//    
//    static func deleteUnFavouriteAlbum (album : Album) {
//        
//        if  (self.favouriteAlbums.value.contains(album)) {
//            
//            self.favouritesCheck[(self.albums.value.indexOf(album))!]!.value = false
//            
//            if favouriteAlbums.value.count < (self.favouriteAlbums.value.indexOf(album))! {
//                
//                self.albumOwners.value.removeAtIndex((self.favouriteAlbums.value.indexOf(album))!)
//                
//                self.favouriteAlbums.value.removeAtIndex((self.favouriteAlbums.value.indexOf(album))!)
//                
//            }
//            
//        }
//        
//        
//        
//    }
    
