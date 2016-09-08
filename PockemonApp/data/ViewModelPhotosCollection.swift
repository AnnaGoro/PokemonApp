//
//  ViewModelPhotosCollection.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class ViewModelPhotosCollection {
    
    
    var photos : Variable <[Photo]> = Variable([])
    
    var albumGlobal : Variable <Album> = Variable(Album())
    
    private let bag = DisposeBag()
    
    
    init (albumGlobal : Album) {
        
        self.albumGlobal.value = albumGlobal
        
        self.albumGlobal.asObservable()
            
            .flatMap { (albumGlobal : Album) -> Observable<[Photo]> in
        
                return ApiServiceGet().recieveAlbumPhotos(albumGlobal)}
            
            .subscribe(
                onNext: { (photos : [Photo] ) in
                self.photos.value = photos
            }
            ).addDisposableTo(bag)
    }
    
    
    
    
    
    
    
   deinit {
        
    print("deinit ViewModelPhotosCollection")
        
        
    }
}



