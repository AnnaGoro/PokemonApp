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
    
    var favouritesCheck : Variable<[Bool]> = Variable([])
    
    var checkBool : Variable<Bool> = Variable(Bool())
    private let apiServiceGet = ApiServiceGet()
    private let bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
    
    var viewModelFavouriteAlbumsCollection : Variable<ViewModelFavouriteAlbums?> = Variable(nil)
    
    
    
    func observeSwitch () {
        
        
        
        
        
    }
    
    var switchRac : Observable<Bool>? {
        
  
        didSet {
            guard let observable = switchRac else { return }
            
            observable
       
      
        .subscribe(
               onNext : { (check : Bool) in
                    self.favouritesCheck.value.append(check)
                
                
         }).addDisposableTo(bag)
        
        
        }

    
    }
    /*
    
    func cellIndexChangedFavouriteAl (index : Int) {
    
    self.viewModelFavouriteAlbumsCollection.value = ViewModelFavouriteAlbums(favouritesCheck.value)
    
    
    }
    
    */
 
    
    func cellIndexChanged (index : Int) {
       
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: albums.value[index])
       
       
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




