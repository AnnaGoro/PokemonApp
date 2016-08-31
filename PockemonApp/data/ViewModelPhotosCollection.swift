//
//  ViewModelPhotosCollection.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class ViewModelPhotosCollection {
    
    
    let title : Variable <String> = Variable( "" )
    
    //let image : Variable <UIImage> = Variable()
    
    private let apiService = ApiService()
    private let bag = DisposeBag()
    
    
    
    // TODO Image Loader !!
    /*
 
     let URL = arrayUrlsPhoto[indexPath.row]
     let placeholder = UIImage(named: "img_nature")!
     cell.imageViewCV.load(URL, placeholder: placeholder) { URL, image, error, cacheType in
     print("URL \(URL)")
     print("error \(error)")
     print("image \(image?.size), render-image \(cell.imageViewCV.image?.size)")
     print("cacheType \(cacheType.hashValue)")
     if cacheType == CacheType.None {
     let transition = CATransition()
     transition.duration = 0.5
     transition.type = kCATransitionFade
     cell.imageViewCV.layer.addAnimation(transition, forKey: nil)
     cell.imageViewCV.image = image
     
     
     }
     
     cell.imageViewCV.layer.cornerRadius = 30.0
     cell.imageViewCV.clipsToBounds = true
     }
 
 */
    
    
}