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

    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!

    
    var disposeBagCell:DisposeBag = DisposeBag()
    
    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }
    


}