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
    
    static var viewModelAlbums : Variable<ViewModelAlbumsList?> = Variable (nil)
    
    static var favouritesCheck : Variable<[Bool]> = Variable([])
    
    
    
    static func switchChangedStateObservable (index : Int, boolState : Bool) {
     
        self.favouritesCheck.value[index] = boolState
        
    }
    
    

    static func addFavouriteAlbum (album : Album) {
        
        if  (viewModel.value?.favouriteAlbums.value.contains(album)) == false {
        
            viewModel.value?.favouriteAlbums.value.append(album)
        
        }
        
        
    }
        
    
    
    static func deleteUnFavouriteAlbum (album : Album) {
        
        if  (viewModel.value?.favouriteAlbums.value.contains(album)) == true {
            
            print((viewModel.value?.albums.value.indexOf(album))!)
            
            print(favouritesCheck.value[(viewModel.value?.albums.value.indexOf(album))!])
            
            self.favouritesCheck.value[(viewModel.value?.albums.value.indexOf(album))!] = false
            
            print(favouritesCheck.value[(viewModel.value?.albums.value.indexOf(album))!])
            
            viewModel.value?.favouriteAlbums.value.removeAtIndex((viewModel.value?.favouriteAlbums.value.indexOf(album))!)
            
           
            
        }

    
    
    }
   
}