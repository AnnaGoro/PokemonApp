//
//  viewModelLikedAlbums.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct ViewModelFavouriteAlbums {
    
    var albums : Variable<[Album]> = Variable([])
    var favouriteAlbums : Variable<[Album]> = Variable([])
    var users : Variable <[User]> = Variable([])
   // var favouritesCheck : Variable<[Bool]> = Variable([])
    private let apiServiceGet = ApiServiceGet()
    
   // private var viewModelAllAlbums = ViewModelAlbumsList()
    
    private let bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
  //  var viewModelAlbumList : Variable<ViewModelAlbumsList?> = Variable(ViewModelAlbumsList())
    

    func switchStateChanged(index : Int, checkBoolSwitch : Bool){
        
       // ReactiveDataFavouriteAlbums.favouritesCheck.value[index] = checkBoolSwitch
        
        if !checkBoolSwitch {
        
            ReactiveDataFavouriteAlbums.deleteUnFavouriteAlbum(favouriteAlbums.value[index])
            //viewModelAllAlbums.favouritesCheck.value[index] = checkBoolSwitch
        }
        
        if checkBoolSwitch {
        
            ReactiveDataFavouriteAlbums.addFavouriteAlbum(albums.value[index])
            
        }
      
    }

    func getViewModelFavouriteAlbumsData (index : Int, checkBoolSwitch : Bool) {
        
        
        apiServiceGet.getAlbums().subscribe(
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
            }
            ).addDisposableTo(bag)
        
        
        apiServiceGet.recieveFavouriteAlbum(albums.value, index: index, checkBoolSwitch: checkBoolSwitch).subscribe(
            onNext: { (albums : [Album] ) in
                print("recieveFavouriteAlbum")
               //  self.favouriteAlbums.value = albums
            
            }
            ).addDisposableTo(bag)
        
        apiServiceGet.favouriteAlbums.asObservable().subscribe( onNext: { (albums : [Album] ) in
            
                self.favouriteAlbums.value = albums
            
            }
            ).addDisposableTo(bag)
        
        
        apiServiceGet.recieveAlbumOwners(self.favouriteAlbums.value).subscribe(
            onNext: { (users : [User]) in
                self.users.value = users
            }
            ).addDisposableTo(bag)
        
       
        
    }
    
    
    func cellIndexChanged (index : Int) {
        
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: albums.value[index])
        
    }
    
    
    
    
    
}