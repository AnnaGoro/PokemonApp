//
//  AlbumLikedCell.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift



class AlbumLikedCell : UITableViewCell {
   
    private var viewModFavouriteAlbumCell : ViewModFavouriteAlbumCell?
    
    @IBOutlet weak var switchLike: UISwitch!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!

   // private var checkBoolValue = false
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
    }
    
    
    func changeCellData (viewModel : ViewModFavouriteAlbumCell) {
        
        self.viewModFavouriteAlbumCell = viewModel
        
        self.viewModFavouriteAlbumCell!.album.asObservable()
            
            .subscribeNext{[weak self] (album : Album) in
                //print(album)
                self!.numberLabel.text = String(album.id)
                self!.titleLabel.text = album.title
            }.addDisposableTo(disposeBag)
        
        
        self.viewModFavouriteAlbumCell!.user.asObservable()
            .subscribeNext{[weak self] (user : User) in
                // print(user)
                self!.userNameLabel.text = user.name
            }.addDisposableTo(disposeBag)
        
        
        
        self.viewModFavouriteAlbumCell!.likeStatusObservable
            .asObservable()
            .subscribeNext{[weak self] (likeStatus : Bool) in
                print()
                print(likeStatus)
                print()
                self!.switchLike.setOn(likeStatus, animated: false)
            }.addDisposableTo(disposeBag)
        
        self.switchLike.rx_value.asObservable()
            
            .subscribeNext{[weak self] (likeStatus : Bool) in
                print()
                print(likeStatus)
                print()
                
                ReactiveDataFavouriteAlbums.addOrDeleteFavouriteAlbum(self!.viewModFavouriteAlbumCell!.album.value.id!-1, checkBoolSwitch : likeStatus)
                
                ReactiveDataFavouriteAlbums.favouritesCheck[(self?.viewModFavouriteAlbumCell?.album.value.id)!-1]!.value = likeStatus
                
                
                print("changeCellData  viewModFavouriteAlbumCell favouritesCheck :")
                print((self?.viewModFavouriteAlbumCell?.album.value.id!)!-1)
                print(ReactiveDataFavouriteAlbums.favouritesCheck[(self?.viewModFavouriteAlbumCell?.album.value.id)!-1]!.value)
                
            }.addDisposableTo(disposeBag)
        
        
        
    }
    
    
    
    
    deinit{
    
    print("deinit AlbumLikedCell")
    
    
    }


}