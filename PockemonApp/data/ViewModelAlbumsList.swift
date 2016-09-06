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
   
   // var favouritesCheck : Variable<[Bool]>?
    
    
    var viewModelCellAlbums : Variable <[ViewModelCellAlbum]> = Variable([])
    
  
    private let apiServiceGet = ApiServiceGet()
    var bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
    
    var viewModelFavouriteAlbumsCollection : Variable<ViewModelFavouriteAlbums?> = Variable(nil)
    
    
    func switchStateChanged(index : Int, checkBoolSwitch : Bool){
        print("switchStateChanged")
        self.viewModelCellAlbums.value[index].switchState.value = checkBoolSwitch
    }
    
    
    func cellIndexChanged (index : Int) {
       
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: albums.value[index])
       
    }
    
    
     init() {
        
        for _  in 0...100 {
            
            var a = ViewModelCellAlbum()
            self.viewModelCellAlbums.value.append(a)
            
            }
        
        apiServiceGet.getAlbums().subscribe(
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
                
                
                print("init ViewModelAlbumsList")
                
            }
            ).addDisposableTo(bag)
        
        apiServiceGet.recieveAlbumOwners(albums.value).subscribe(
            onNext: { (users : [User]) in
                var a = ViewModelCellAlbum()
                self.viewModelCellAlbums.value.append(a)
                
                self.users.value = users
            }
            ).addDisposableTo(bag)
                 //self.viewModelCellAlbums  = Variable([ViewModelCellAlbum] (count : albums.value.count, repeatedValue: ViewModelCellAlbum() ))
    }
}




