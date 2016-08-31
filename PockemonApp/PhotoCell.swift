//
//  photoCell.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class PhotoCell : UICollectionViewCell{


    @IBOutlet weak var photoImageView: UIImageView!
    
    var disposeBagCell:DisposeBag = DisposeBag()
    
    
    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }

}
