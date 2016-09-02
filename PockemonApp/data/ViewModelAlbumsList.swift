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

struct ViewModelAlbumsList {
    
    var albums : Variable<[Album]> = Variable([])
    var users : Variable <[User]> = Variable([])
    var user : Variable <User> = Variable(User())
    
    private let apiServiceGet = ApiServiceGet()
    private let bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
    
    
    var indexPathCellRac : Observable<Int>? {
        
        didSet {
            
            indexPathCellRac?.map { (indexPath : Int) -> Album in
                return self.albums.value[indexPath]
                }.subscribe(
                    onNext : {(album : Album) in
                        return self.viewModelPhotosCollection.value
                            = ViewModelPhotosCollection(albumGlobal: album)
                        
                }).addDisposableTo(bag)
        }
        
    }
    
    
    init() {
        
        
        apiServiceGet.getAlbums().subscribe(
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
            }
            ).addDisposableTo(bag)
        
        
        
        apiServiceGet.recieveAlbumOwners(albums.value).subscribe(
            onNext: { (users : [User]) in
                self.users.value = users
            }
            ).addDisposableTo(bag)
        
    }
}




