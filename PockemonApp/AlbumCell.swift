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
    
    @IBOutlet weak var switchCheck: UISwitch!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var number: UILabel!
    
    private(set) var disposeBag = DisposeBag()
    
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
        
        super.prepareForReuse()        
        
    }   

    
    
    func changeSwitchState(index : Int) {
        
               
        self.viewModelAlbumList.favouritesCheck.asObservable().subscribeNext {(values : [Bool]) in
         
            self.switchCheck.setOn(values[index], animated: false)
            
            }.addDisposableTo(disposeBag)
    }
    
    

}