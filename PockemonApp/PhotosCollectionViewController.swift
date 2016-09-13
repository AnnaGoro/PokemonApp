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
import RxDataSources

class PhotosCollectionViewController : UICollectionViewController {
    
    var viewModelPhotosCollection : ViewModelPhotosCollection?
    
    var dataSourceCollection: RxCollectionViewSectionedAnimatedDataSource<SectionOfPhotos>?
    
    @IBOutlet var dataSource: UICollectionView!
    
    
    private(set) var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModelPhotosCollection?.albumGlobal.value.title
        
        setUpViewModel()
        
    }
    
   
    private func setUpViewModel() {
        
        self.dataSource.delegate = nil
        self.dataSource.dataSource = nil
        
        dataSource
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
        
        let dataSourceCollection = RxCollectionViewSectionedAnimatedDataSource<SectionOfPhotos>()
        
        viewModelPhotosCollection?.sections.asObservable()
            
            .bindTo(dataSource.rx_itemsWithDataSource(dataSourceCollection))
            
            .addDisposableTo(disposeBag)
        
        
        self.dataSourceCollection = dataSourceCollection
        
        dataSourceCollection.cellFactory = { [weak self] (dataSource, collectionView, indexPath, photo) in
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
            
            cell.loadPhoto(photo)
            
            return cell
        }
        
      
        
    }

}
    

