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
    
    var checkBoolValue : Bool?
    
    @IBOutlet weak var switchCheck: UISwitch!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var number: UILabel!
    
    private(set) var disposeBag = DisposeBag()    
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
        
        super.prepareForReuse()
        
    }
    
    
    func changeSwitchState(checkBoolValue : Bool) {
        
        self.checkBoolValue = checkBoolValue
        self.switchCheck.setOn(checkBoolValue, animated: false)
        
        
    }
    
    
    
}