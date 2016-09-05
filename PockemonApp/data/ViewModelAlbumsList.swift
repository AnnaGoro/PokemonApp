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
    
    
    var switchRac : Observable<Bool>? {
       /*
        didSet {
            guard let observable = switchRac else { return }
            
            observable
            
                .subscribe(
                    onNext : { (check : Bool) in
                        print(check)
                        
                        return self.checkBool.value = check
                        
                        
                }).addDisposableTo(bag)
            
            
        }
 */
  
        didSet {
            guard let observable = switchRac else { return }
            
            observable
       
            .map { (check : Bool) -> [Bool] in
              //  print("switchRac  \(check)")
                self.favouritesCheck.value.append(check)
                return self.favouritesCheck.value
                
            }.subscribe(
               onNext : { (checks : [Bool]) in
                    return self.favouritesCheck.value = checks
                
         }).addDisposableTo(bag)
        
        
        }

    
    }
    
    func cellIndexChanged (index : Int) {
        //print(albums.value[index].title)
        self.viewModelPhotosCollection.value = ViewModelPhotosCollection(albumGlobal: albums.value[index])
       // print(self.viewModelPhotosCollection.value?.photos.value.first?.title)

       
    }
    
    //var albumViewModel: Variable<AlbumViewModel?>
   /*
    var indexPathCellRac : Observable<Int>? {
        
        didSet {
            
            indexPathCellRac?.map { (indexPath : Int) -> Album in
                print(" indexPathCellRac  \(indexPath)")
                return self.albums.value[indexPath]
                }.subscribe(
                    onNext : {(album : Album) in
                        print(self.viewModelPhotosCollection.value?.albumGlobal.value.title)
                        return self.viewModelPhotosCollection.value
                            = ViewModelPhotosCollection(albumGlobal: album)
                       
                        
                }).addDisposableTo(bag)
        }
        
    }
    

    
    */
    
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




