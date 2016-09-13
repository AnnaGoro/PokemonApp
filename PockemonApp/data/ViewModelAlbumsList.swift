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
import RxDataSources


class ViewModelAlbumsList {
    
    var sections : Variable<[SectionOfData]> = Variable([])
    private let apiServiceGet = ApiServiceGet()
    
    var bag = DisposeBag()
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
    
    func cellIndexChanged (index : Int) {
        
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: (sections.value.first?.items[index].album)!)
        
    }
    
    
    init() {
        
        apiServiceGet.getAlbums()
            
            .map { (albums : [Album]) -> [ViewModelCell] in
                
                return albums.map { (album : Album) -> ViewModelCell in
                    
                    return ViewModelCell(album: album)
                }
                
            }
            .map{ (cells : [ViewModelCell]) -> [SectionOfData] in
                
                return [SectionOfData (header : "Favourite Albums", items : cells)]
                
            }
            .subscribeNext { (sections: [SectionOfData]) in
                
                self.sections.value = sections
            }
            .addDisposableTo(bag)
        
    }
    
    deinit{
        
        print("deinit ViewModelAlbumsList")
        
    }
    
}

