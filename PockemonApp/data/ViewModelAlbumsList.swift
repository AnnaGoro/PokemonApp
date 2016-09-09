//
//  viewModelAlbumsList.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModelAlbumsList {
    
    var albums : Variable<[Album]> = Variable([])
    
    var viewModelCellsArray : Variable<[ViewModelCell]> = Variable([ViewModelCell]())
    
    
    private let apiServiceGet = ApiServiceGet()
    
    var bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
    
    var viewModelFavouriteAlbumsCollection : Variable<ViewModelFavouriteAlbums?> = Variable(ViewModelFavouriteAlbums())
    
    
    func cellIndexChanged (index : Int) {
        
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: albums.value[index])
        
    }
    
    
    func setViewModelToStatic () {
        
        ReactiveDataFavouriteAlbums.viewModel.value = self.viewModelFavouriteAlbumsCollection.value
        
    }
    
    init() {
        
        
        
        apiServiceGet.getAlbums()
            
            .subscribe(
                onNext: { (albums : [Album] ) in
                    self.albums.value = albums
                    ReactiveDataFavouriteAlbums.albums.value = self.albums.value
                }
            ).addDisposableTo(bag)
        
        for i  in 0..<self.albums.value.count {
            
            self.viewModelCellsArray.value.append(ViewModelCell(album: self.albums.value[i]))
            
            ReactiveDataFavouriteAlbums.favouritesCheck.updateValue(Variable(false), forKey: i)
            
        }
        
        apiServiceGet.recieveAlbumOwners( self.albums.value)
            .subscribe(
                onNext: { (users : [User] ) in
                    
                    ReactiveDataFavouriteAlbums.albumOwners.value = users
                    
                    
                }
            ).addDisposableTo(bag)
        
        
    }
    
    deinit{
        
        print("deinit ViewModelAlbumsList")
        
    }
    
}

