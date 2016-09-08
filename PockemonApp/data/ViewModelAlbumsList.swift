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
    var users : Variable <[User]> = Variable([])
   
  //  var viewModelAlbumsList : Variable<ViewModelAlbumsList> = Variable(ViewModelAlbumsList())
 
    private let apiServiceGet = ApiServiceGet()
    var bag = DisposeBag()
    
    var viewModelPhotosCollection : Variable<ViewModelPhotosCollection?> = Variable(nil)
    
    var viewModelFavouriteAlbumsCollection : Variable<ViewModelFavouriteAlbums?> = Variable(ViewModelFavouriteAlbums())
    
    
    
    func switchStateChanged(index : Int, checkBoolSwitch : Bool){
  
        ReactiveDataFavouriteAlbums.switchChangedStateObservable(index, boolState: checkBoolSwitch)
        
        if checkBoolSwitch {
            
            self.viewModelFavouriteAlbumsCollection.value?.getViewModelFavouriteAlbumsData(index, checkBoolSwitch: ReactiveDataFavouriteAlbums.favouritesCheck.value[index])
        }
        
    }
    
    
    func cellIndexChanged (index : Int) {
        print("cellIndexChanged")
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: albums.value[index])
       
    }
    
    
    func setViewModelToStatic () {
     
        ReactiveDataFavouriteAlbums.viewModel.value = self.viewModelFavouriteAlbumsCollection.value
    
    }
    
     init() {
        print("init ViewModelAlbumsList")
       
        //   self.viewModelFavouriteAlbumsCollection.value = ViewModelFavouriteAlbums()
               
        apiServiceGet.getAlbums().subscribe(
            onNext: { (albums : [Album] ) in
                self.albums.value = albums
            }
            ).addDisposableTo(bag)
        
        apiServiceGet.recieveAlbumOwners(self.albums.value).subscribe(
            onNext: { (users : [User]) in
                
                self.users.value = users
            }
            ).addDisposableTo(bag)
       
        print("-------- self.users.value.count --------")
        print(self.users.value.count)
        print()
        
        
        if (ReactiveDataFavouriteAlbums.favouritesCheck.value.count < users.value.count-2) {
            print("******************")
            print(ReactiveDataFavouriteAlbums.favouritesCheck.value.count)

            for _  in 0...self.users.value.count {
            
                let a = false
                ReactiveDataFavouriteAlbums.favouritesCheck.value.append(a)

        }
        }
        print("********   checks after   **********")
        print(ReactiveDataFavouriteAlbums.favouritesCheck.value.count)
       }

    deinit{
    
    print("deinit ViewModelAlbumsList")
    
    }

}

