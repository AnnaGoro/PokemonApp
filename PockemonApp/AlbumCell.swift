//
//  CellPokemonCollection.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class AlbumCell : UITableViewCell {
    
    //var viewModelAlbumList = ViewModelAlbumsList()
    private var viewModelCell : ViewModelCell?
    
   // var checkBoolValue : Bool?
    
    @IBOutlet weak var switchCheck: UISwitch!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var number: UILabel!
    
    private(set) var disposeBag = DisposeBag()    
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
        
        super.prepareForReuse()
        
    }
    
    /*
    func changeSwitchState(checkBoolValue : Bool) {
        
        self.checkBoolValue = checkBoolValue
        self.switchCheck.setOn(checkBoolValue, animated: false)
        
        
    }
    
 */
    func changeCellData (viewModel : ViewModelCell) {
        
        self.viewModelCell = viewModel
    
        self.viewModelCell!.album.asObservable()
            
            .subscribeNext{[weak self] (album : Album) in
            //print(album)
            self!.number.text = String(album.id)
            self!.title.text = album.title
            }.addDisposableTo(disposeBag)
        

        self.viewModelCell!.user.asObservable()
            .subscribeNext{[weak self] (user : User) in
               // print(user)
                self!.userName.text = user.name
            }.addDisposableTo(disposeBag)
      
        
        
        self.viewModelCell!.likeStatusObservable
            .asObservable()
            .subscribeNext{[weak self] (likeStatus : Bool) in
                print()
                print(likeStatus)
                print()
                self!.switchCheck.setOn(likeStatus, animated: false)
            }.addDisposableTo(disposeBag)
        
        self.switchCheck.rx_value.asObservable()
            
        .subscribeNext{[weak self] (likeStatus : Bool) in
            print()
            print(likeStatus)
            print()
            
            ReactiveDataFavouriteAlbums.addOrDeleteFavouriteAlbum(self!.viewModelCell!.album.value.id!-1, checkBoolSwitch : likeStatus)
            ReactiveDataFavouriteAlbums.favouritesCheck[(self?.viewModelCell?.album.value.id)!-1]!.value = likeStatus
            
            ReactiveDataFavouriteAlbums.getFavouriteAlbums (ReactiveDataFavouriteAlbums.albums.value, index : ((self?.viewModelCell?.album.value.id)!-1), checkboolSwitch : ReactiveDataFavouriteAlbums.favouritesCheck[(self?.viewModelCell?.album.value.id)!-1]!.value)
            
            print("changeCellData favouritesCheck :")
            print((self?.viewModelCell?.album.value.id!)!-1)
            print(ReactiveDataFavouriteAlbums.favouritesCheck[(self?.viewModelCell?.album.value.id)!-1]!.value)
            
            }.addDisposableTo(disposeBag)
        

    
    }
    
    
}