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



struct ViewModelPhotosCollection {
    
    
    var photos : Variable <[Photo]> = Variable([])
  
    var albumGlobal : Variable <Album> = Variable(Album())
    
    private let bag = DisposeBag()
    private let apiServiceGet = ApiServiceGet()
    var count = 0
    
     /*
    var album : Observable<Album>? {
        didSet {
            album?.flatMapLatest{ (album : Album) -> Observable<[Photo]> in
                return self.apiServiceGet.recieveAlbumPhotos(album)
                }
                .subscribeNext{ (allPhotos : [Photo]) in
                    self.photos.value = allPhotos
                }
                .addDisposableTo(bag)
        }
    }
     */

  
    init (albumGlobal : Album) {
        
       self.albumGlobal.value = albumGlobal
        
        apiServiceGet.recieveAlbumPhotos(albumGlobal).subscribe(
            onNext: { (photos : [Photo] ) in
                self.photos.value = photos
            }
            ).addDisposableTo(bag)
        
    }
}

    
   
    /*
 
 var obs : Observable<[Photo]>?{
 
 didSet {
 count+=1
 print(count)
 apiServiceGet.recieveAlbumPhotos(self.album.value).subscribe(
 onNext: { (photos : [Photo] ) in
 self.photos.value = photos
 }
 ).addDisposableTo(bag)
 
 
 }
 
 
 
 }

*/

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
    
    
