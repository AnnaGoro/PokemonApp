//
//  ViewModFavouriteAlbumCell.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 09.09.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct ViewModFavouriteAlbumCell {
    
    var album : Variable<Album> = Variable(Album())
    var user : Variable<User> = Variable(User())
    
    
    private let apiServiceGet = ApiServiceGet()
    
    var bag = DisposeBag()
    
    
    
    var likeStatusObservable : Variable<Bool>  {
        
        return ReactiveDataFavouriteAlbums.favouritesCheck[album.value.id!-1]!
    }
    
    
    
    init (album : Album) {
        
        self.album.value = album
        
        apiServiceGet.recieveAlbumOwner(self.album.value).subscribe(
            onNext: { (user : User) in
                
                self.user.value = user
            }
            ).addDisposableTo(bag)
        
        
    }
    
}
