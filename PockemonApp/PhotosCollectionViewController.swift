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
        print(" viewModelPhotosCollection!.photos.value.count  \(viewModelPhotosCollection!.photos.value.count)")
        return viewModelPhotosCollection!.photos.value.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell
  
        cell.photoImageView.load(viewModelPhotosCollection!.photos.value[indexPath.item].url!)
        //cell.photoImageView.layer.cornerRadius = 30.0
       // cell.photoImageView.clipsToBounds = true
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
     
    }
    
    
    private func setUpViewModel() {
        
        viewModelPhotosCollection!.photos.asObservable()
            .subscribeNext {[weak self] (photos : [Photo]) in
                
            self!.title = self!.viewModelPhotosCollection!.albumGlobal.value.title
            self!.dataSource.reloadData()
            
            }.addDisposableTo(disposeBag)        
        
    }
    
    
}
