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
import RxDataSources

struct ViewModelPhotosCollection {
    
    var sections : Variable<[SectionOfPhotos]> = Variable([])
    
    
    var albumGlobal : Variable <Album> = Variable(Album())
    
    private let bag = DisposeBag()
    
    
    init (albumGlobal : Album) {
        
        self.albumGlobal.value = albumGlobal
        
        self.albumGlobal.asObservable()
            
            .flatMap { (albumGlobal : Album) -> Observable<[Photo]> in
                
                return ApiServiceGet().recieveAlbumPhotos(albumGlobal)}
            
            .map{ (photos : [Photo]) -> [SectionOfPhotos] in
                
                return [SectionOfPhotos (header : "Photos", items : photos)]
                
            }
            .subscribeNext { (sections: [SectionOfPhotos]) in
                
                self.sections.value = sections
            }
            .addDisposableTo(bag)
    }
    
    
    
}



