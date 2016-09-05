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
    
    private let disposeBag = DisposeBag()
    
    private let reuseIdentifier = "photoCell"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewModel()
       
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let a = viewModelPhotosCollection?.photos.value.count {
        return a
            
        } else {
            print("viewModelPhotosCollection?.photos.value.count = nil")
            
            return 0
        }
        
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell
        
        if let url = viewModelPhotosCollection?.photos.value[indexPath.item].url {
        
        cell.photoImageView.load(url)
        } else {
        
            print("viewModelPhotosCollection?.photos.value[indexPath.item].url  = nil")
        
        }
        
        return cell
    }
    

    private func setUpViewModel() {
        
        viewModelPhotosCollection?.photos.asObservable()
            
            .subscribeNext {[weak self] (photos : [Photo]) in
                
            self?.title = self?.viewModelPhotosCollection!.albumGlobal.value.title
            self!.dataSource.reloadData()
            
            }.addDisposableTo(disposeBag)        
        
    }
    
    
}
