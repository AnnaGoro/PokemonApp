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
    
    private let apiServiceGet = ApiServiceGet()
    
    private let bag = DisposeBag()
    
    func getViewModelFavouriteAlbumsData (index : Int, checkBoolSwitch : Bool) {
        
        
        apiServiceGet.getAlbums().subscribe(
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
            }
            ).addDisposableTo(bag)
        
        
        apiServiceGet.recieveFavouriteAlbum(albums.value, index: index, checkBoolSwitch: checkBoolSwitch).subscribe(
            onNext: { (albums : [Album] ) in
                // self.favouriteAlbums.value = albums
            }
            ).addDisposableTo(bag)
        
        apiServiceGet.favouriteAlbums.asObservable().subscribe( onNext: { (albums : [Album] ) in
            
            self.favouriteAlbums.value = albums
            print("--------------------------------------------------")
            
            for value in  self.favouriteAlbums.value  {
                
                
                print(value)
                
            }
            print()
            }
            ).addDisposableTo(bag)
        
        
        apiServiceGet.recieveAlbumOwners(self.favouriteAlbums.value).subscribe(
            onNext: { (users : [User]) in
                self.users.value = users
            }
            ).addDisposableTo(bag)
        

        
        
        
    }
    
    init () {
    
    }
    
    
    
    
    init(index : Int, checkBoolSwitch : Bool) {
        
        
        apiServiceGet.getAlbums().subscribe(
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
            }
            ).addDisposableTo(bag)
        
        
        apiServiceGet.recieveFavouriteAlbum(albums.value, index: index, checkBoolSwitch: checkBoolSwitch).subscribe(
            onNext: { (albums : [Album] ) in
                // self.favouriteAlbums.value = albums
            }
            ).addDisposableTo(bag)
        
        apiServiceGet.favouriteAlbums.asObservable().subscribe( onNext: { (albums : [Album] ) in
            
            self.favouriteAlbums.value = albums
            print("--------------------------------------------------")
      
            for value in  self.favouriteAlbums.value  {
                
                
                print(value)
                
            }
            print()
            }
            ).addDisposableTo(bag)
        
        
        apiServiceGet.recieveAlbumOwners(self.favouriteAlbums.value).subscribe(
            onNext: { (users : [User]) in
                self.users.value = users
            }
            ).addDisposableTo(bag)
        
    }
    
    
    
    
}