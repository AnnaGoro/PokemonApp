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


    static var viewModel : Variable<ViewModelFavouriteAlbums?> = Variable(nil)

    
    static var favouritesCheck : [Int : Variable<Bool>] = [Int : Variable<Bool>]()
    
    static var albums : Variable<[Album]> = Variable([Album]())
    
    static var favouriteAlbums : Variable<[Album]> = Variable([Album]())
    
    static var albumOwners : Variable<[User]> = Variable([User]())
    
    static var apiService = ApiServiceGet()
  
    
    static func getFavouriteAlbums (albums : [Album], index : Int, checkboolSwitch : Bool) {
    
       apiService.recieveFavouriteAlbums(albums, index: index, checkBoolSwitch: checkboolSwitch)
        
       apiService.favouriteAlbums.asObservable().subscribeNext { (albums : [Album]) in
        
            self.favouriteAlbums.value = albums
            
        }.addDisposableTo(DisposeBag())
    
    }
    

    static func addFavouriteAlbum (album : Album) {
        
        if  !(self.favouriteAlbums.value.contains(album)){
        
             self.favouriteAlbums.value.append(album)
        
        }
        
        
    }
        
    static func addOrDeleteFavouriteAlbum(index : Int, checkBoolSwitch : Bool){
        
        
        if !checkBoolSwitch {
            
            
            guard favouriteAlbums.value.count > index else { return }

            deleteUnFavouriteAlbum(favouriteAlbums.value[index])
                
        }else {
            
           addFavouriteAlbum(albums.value[index])
            
        }
        
    }
    

    
    static func deleteUnFavouriteAlbum (album : Album) {
        
        if  (self.favouriteAlbums.value.contains(album)) {
            
            self.favouritesCheck[(self.albums.value.indexOf(album))!]!.value = false
            
            if !favouriteAlbums.value.isEmpty {
                
                self.albumOwners.value.removeAtIndex((self.favouriteAlbums.value.indexOf(album))!)
            
                self.favouriteAlbums.value.removeAtIndex((self.favouriteAlbums.value.indexOf(album))!)
            
            }
            
        }

    
    
    }
   
}