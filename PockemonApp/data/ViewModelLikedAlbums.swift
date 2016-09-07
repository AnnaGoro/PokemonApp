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
    
    var photos : Variable <[Photo]> = Variable([])
    
    var album : Variable <Album> = Variable(Album())
    
   var favouritesCheck : Variable<[Bool]> = Variable([])
    
    
    
    init(favouriteChecks : [Bool]) {
        
        
        apiServiceGet.getAlbums().subscribe(
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
            }
            ).addDisposableTo(bag)
            
        apiServiceGet.recieveFavouriteAlbums(albums.value, favouriteChecks: favouriteChecks).subscribe(
            onNext: { (albums : [Album] ) in
                self.favouriteAlbums.value = albums
            }
            ).addDisposableTo(bag)
        
        apiServiceGet.recieveAlbumOwners(favouriteAlbums.value).subscribe(
            onNext: { (users : [User]) in
                self.users.value = users
            }
            ).addDisposableTo(bag)
        
    }


    
    
}