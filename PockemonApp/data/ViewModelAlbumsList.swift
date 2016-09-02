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
    
   // var viewModelPhotosCollection = ViewModelPhotosCollection ()
    
    
    
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
/*
 
 
 apiServiceGet.getAlbums().subscribe(
 
 onNext: { (albums : [Album] ) in
 self.albums.value = albums
 
 albums.map{ (album : Album) -> Observable<User> in
 
 return self.apiServiceGet.recieveAlbumOwner(album).map({ (user : User) -> User in
 self.user.value = user
 self.users.value.append(self.user.value)
 return user
 })
 return user.value
 }
 } ).addDisposableTo(bag)
 }

 
 
 
 
 
 */




