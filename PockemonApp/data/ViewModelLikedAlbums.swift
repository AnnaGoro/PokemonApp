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
    
    var viewModelCellsArray : Variable<[ViewModFavouriteAlbumCell]> = Variable([ViewModFavouriteAlbumCell]())
    
    private let apiServiceGet = ApiServiceGet()
    
    private let bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
    
    
    func getViewModelFavouriteAlbumsData (index : Int) {
        
        apiServiceGet.getAlbums()
            
            .subscribe(
                onNext: { (albums : [Album] ) in
                    self.albums.value = albums
                }
            ).addDisposableTo(bag)
        
        
        apiServiceGet.recieveFavouriteAlbums(self.albums.value, index: index,
            
            checkBoolSwitch: ReactiveDataFavouriteAlbums.favouritesCheck[index]!.value)
            .subscribe(
                onNext: { (albums : [Album] ) in
                    
                    self.favouriteAlbums.value = albums
                    ReactiveDataFavouriteAlbums.favouriteAlbums.value = self.favouriteAlbums.value
                    
                }
            ).addDisposableTo(bag)
        
        
        for i  in 0..<self.favouriteAlbums.value.count {
            
            self.viewModelCellsArray.value.append(ViewModFavouriteAlbumCell(album: self.favouriteAlbums.value[i]))
            
        }
        
    }
    
    
    init() { print ("init ViewModelFavouriteAlbums")}
    
    
    func cellIndexChanged (index : Int) {
        
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: albums.value[index])
        
    }
    
    
    
    
    
}