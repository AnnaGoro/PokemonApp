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
   
    var viewModelAlbumList = ViewModelAlbumsList()
    
    var viewModelCellAlbum : ViewModelCellAlbum?
    
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
    
    func changeCellDataState(viewModelCellAlbum : ViewModelCellAlbum) {
        
        self.viewModelCellAlbum = viewModelCellAlbum
        
        self.viewModelCellAlbum?.number.asObservable().subscribeNext{(number) in
            self.number.text! = String(number)
            }.addDisposableTo(disposeBag)
        
        self.viewModelCellAlbum?.switchCheck.asObservable().subscribeNext {(checkBoolValue) in
            self.switchCheck.setOn(checkBoolValue, animated: false)
            }.addDisposableTo(disposeBag)
        
        self.viewModelCellAlbum?.title.asObservable().subscribeNext{(title) in
            self.title.text! = title
            }.addDisposableTo(disposeBag)
        
        self.viewModelCellAlbum?.userName.asObservable().subscribeNext{(user) in
            self.userName.text! = (user?.username!)!
            }.addDisposableTo(disposeBag)
        

    }
    
    */
    
    
    func changeSwitchState(viewModel : ViewModelCellAlbum) {
        
        print("changeSwitchState")
        
        self.viewModelCellAlbum = viewModel
        
        self.viewModelCellAlbum?.switchState.asObservable().subscribeNext { (switchState : Bool) in
         
            self.switchCheck.setOn(switchState, animated: false)
            print(switchState)
            
            }.addDisposableTo(self.disposeBag)
    }
    
    

}