//
//  ViewModelCell.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 09.09.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

struct ViewModelCell {
    
    private(set) var album : Album
    private(set) var user : User? = nil
    
    private let apiServiceGet = ApiServiceGet()
    var bag = DisposeBag()
    
    var likeStatusObservable: Observable<Bool> {
        return ReactiveDataFavouriteAlbums.favouritesCheck[album.id!]!.asObservable()
    }
  
    func likeStatusChanged (likeStatus : Bool) {    
    
        ReactiveDataFavouriteAlbums.setLikeStatus(album, status: likeStatus)
    }
    
    
    init (album : Album) {
        
        self.album = album
        
        apiServiceGet.recieveAlbumOwner(self.album).subscribe(
            onNext: { (user : User) in
                
                self.user = user
            }
            ).addDisposableTo(bag)
        
    }
    
}


extension ViewModelCell : Hashable, IdentifiableType, Equatable  {
    
    
    var hashValue : Int {
        get {
            return self.album.id!.hashValue + (user?.userId?.hashValue)!
        }
    }
    
    var identity: String {
        
        return album.title!
        
    }
    
}

func ==(lhs: ViewModelCell, rhs: ViewModelCell) -> Bool {
    
    return lhs.album == rhs.album &&
        lhs.user == rhs.user    
}




