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

class PhotosCollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var viewModelPhotosCollection : ViewModelPhotosCollection?
    
    @IBOutlet var dataSource: UICollectionView!
    private let disposeBag = DisposeBag()
    
    private let reuseIdentifier = "photoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewModel()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModelPhotosCollection!.photos.value.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell
       
        cell.albumTitle.text = viewModelPhotosCollection!.photos.value[indexPath.item].url
       
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
     
    }
    
    
    private func setUpViewModel() {
        
        viewModelPhotosCollection!.photos.asObservable().subscribeNext { ( photos : [Photo]) in
            self.title = self.viewModelPhotosCollection!.album.value.title
            self.dataSource.reloadData()
            
            }.addDisposableTo(disposeBag)        
        
    }
    
    
}
