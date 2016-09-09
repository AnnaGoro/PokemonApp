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
    
    private var viewModelCell : ViewModelCell?
    
    @IBOutlet weak var switchCheck: UISwitch!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var number: UILabel!
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
        
        super.prepareForReuse()
        
    }
    
    
    func changeCellData (viewModel : ViewModelCell) {
        
        self.viewModelCell = viewModel
        
        self.viewModelCell!.album.asObservable()
            
            .subscribeNext{[weak self] (album : Album) in
                
                self!.number.text = String(album.id!)
                self!.title.text = album.title!
            }.addDisposableTo(disposeBag)
        
        
        self.viewModelCell!.user.asObservable()
            .subscribeNext{[weak self] (user : User) in
                
                self!.userName.text = user.name
            }.addDisposableTo(disposeBag)
        
        
        
        self.viewModelCell!.likeStatusObservable
            .asObservable()
            .subscribeNext{[weak self] (likeStatus : Bool) in
                
                self!.switchCheck.setOn(likeStatus, animated: false)
            }.addDisposableTo(disposeBag)
        
        self.switchCheck.rx_value.asObservable()
            
            .subscribeNext{[weak self] (likeStatus : Bool) in
                
                ReactiveDataFavouriteAlbums.addOrDeleteFavouriteAlbum(self!.viewModelCell!.album.value.id!-1,
                    checkBoolSwitch : likeStatus)
                ReactiveDataFavouriteAlbums.favouritesCheck[(self?.viewModelCell?.album.value.id)!-1]!.value = likeStatus
                
                ReactiveDataFavouriteAlbums.getFavouriteAlbums (ReactiveDataFavouriteAlbums.albums.value, index : ((self?.viewModelCell?.album.value.id)!-1), checkboolSwitch : ReactiveDataFavouriteAlbums.favouritesCheck[(self?.viewModelCell?.album.value.id)!-1]!.value)
                
                
            }.addDisposableTo(disposeBag)
        
        
        
    }
    
    
}