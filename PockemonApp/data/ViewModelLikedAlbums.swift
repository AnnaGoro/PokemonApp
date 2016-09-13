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
import RxDataSources


struct ViewModelFavouriteAlbums {
    
    
    var viewModelCellsArray : Variable<[ViewModelCell]> = Variable([])
    
    private let apiServiceGet = ApiServiceGet()
    private let bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)    
    
    
    func cellIndexChanged (index : Int) {
        
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: viewModelCellsArray.value[index].album)
        
    }
    
    
    init() {
        
        ReactiveDataFavouriteAlbums.favouritesCheck
            .map { (tuple : (Int, Variable<Bool>)) -> Observable<Bool>  in
                return tuple.1.asObservable()
            }
            .combineLatest { $0 }
            .flatMap { _ in
            
                return ApiServiceGet().getAlbums()
            
            }
            .map { (albums : [Album]) -> [ViewModelCell] in
                
                let a : [Album] = albums.filter{ (album : Album) -> Bool in
                    
                    return (ReactiveDataFavouriteAlbums.favouritesCheck[album.id!]!.value)
                    
                }
                
                let b : [ViewModelCell] = a.map { (album : Album) -> ViewModelCell in
                    
                    return ViewModelCell(album: album)
                    
                }
                
                return b
                
            }
            .subscribeNext { (cells: [ViewModelCell]) in
                
                self.viewModelCellsArray.value = cells
            }
            .addDisposableTo(bag)
        
        
        
    }
    

    
    
    
    
    
    
}