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
    
    var disposeBag: DisposeBag?    
    
    @IBOutlet weak var albumTitle: UILabel!
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
        
        super.prepareForReuse()
    }
    
    
    func loadPhoto (photo : Photo) {
    
        guard let url = photo.url else {return}
        
        self.photoImageView.load(url)
    
    
    }
    
    
    deinit {
        
    }
    
    
    
}
