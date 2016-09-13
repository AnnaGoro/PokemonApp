//
//  DetailViewController.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import ImageLoader

class PhotosCollectionViewController : UICollectionViewController {
    
    var viewModelPhotosCollection : ViewModelPhotosCollection?
    
    @IBOutlet var dataSource: UICollectionView!
        
    private let reuseIdentifier = "photoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModelPhotosCollection?.albumGlobal.value.title        
        
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
            return (viewModelPhotosCollection?.photos.count)!
        
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell
        
        if let url = viewModelPhotosCollection?.photos[indexPath.item].url {            
            cell.photoImageView.load(url)
            
        }
        
        return cell
    }
    
}
