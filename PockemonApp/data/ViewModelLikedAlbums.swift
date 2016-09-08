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
    var albumOwners : Variable <[User]> = Variable([])
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
        
        
        apiServiceGet.recieveFavouriteAlbums(albums.value, index: index, checkBoolSwitch: checkBoolSwitch).subscribe(
            onNext: { (albums : [Album] ) in
                print("recieveFavouriteAlbum")
                 self.favouriteAlbums.value = albums
            
            }
            ).addDisposableTo(bag)
       /*
        apiServiceGet.favouriteAlbums.asObservable().subscribe( onNext: { (albums : [Album] ) in
            
                //self.favouriteAlbums.value = albums
            
            }
            ).addDisposableTo(bag)
        
          */
        
        apiServiceGet.recieveAlbumOwners(self.favouriteAlbums.value).subscribe(
            onNext: { (users : [User]) in
                self.albumOwners.value = users
                //print(users)
            }
            ).addDisposableTo(bag)
        
        
        print("recieveAlbumOwners in ViewModelFavouriteAlbums")
        print(self.albumOwners.value.count)
    }
    
    
    init () {}
    
    func cellIndexChanged (index : Int) {
        
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: albums.value[index])
        
    }
    
    
    
    
    
}