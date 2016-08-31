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

   
    @IBOutlet weak var `switch`: UIView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var number: UILabel!
    
    var disposeBagCell:DisposeBag = DisposeBag()        
    
        
    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }
    
    
    
    
}