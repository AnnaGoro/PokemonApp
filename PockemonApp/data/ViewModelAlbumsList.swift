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
   
    var favouritesCheck : Variable<[Bool]> = Variable([])
 
    private let apiServiceGet = ApiServiceGet()
    var bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
    
    var viewModelFavouriteAlbumsCollection : Variable<ViewModelFavouriteAlbums?> = Variable(nil)
    
    
    
    func switchStateChanged(index : Int, checkBoolSwitch : Bool){
  
        self.favouritesCheck.value[index] = checkBoolSwitch
        
        
        self.viewModelFavouriteAlbumsCollection.value = ViewModelFavouriteAlbums(index: index, checkBoolSwitch: checkBoolSwitch)
        //self.viewModelFavouriteAlbumsCollection.value = ViewModelFavouriteAlbums(favouriteChecks: favouritesCheck.value)
      
    }
    
    
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
       
        
        for _  in 0...users.value.count {
            
            let a = false
            self.favouritesCheck.value.append(a)

        }
}


}

