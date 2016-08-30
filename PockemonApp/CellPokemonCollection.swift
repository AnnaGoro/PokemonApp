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

class CellPokemonCollection : UICollectionViewCell {


    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var dislike: UIImageView!
    @IBOutlet weak var like: UIImageView!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weight: UILabel!
   
    
    var disposeBagCell:DisposeBag = DisposeBag()        
    
        
    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }
    
    
    
    
}