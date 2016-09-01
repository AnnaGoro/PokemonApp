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

    private let apiServiceGet = ApiServiceGet()
    private let bag = DisposeBag()
    
    
    init() {
    
        apiServiceGet.getAlbums().subscribe(
            
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
             }
            ).addDisposableTo(bag)
       
    }
   
    
}