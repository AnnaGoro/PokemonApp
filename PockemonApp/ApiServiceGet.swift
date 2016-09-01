//
//  ApiServiceGetPokemons.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift
import ObjectMapper



class ApiServiceGet {
    
    
    func recieveAlbumOwner(album : Album) -> Observable<User> {
        
        return getUsers().map { (users : [User]) -> User in
            
            return users.filter { (user : User) -> Bool in
                return user.userId == album.userId
                }.first!
            
        }
        
    }
    
    
    
    func recieveAlbumPhotos (album : Album) -> Observable <[Photo]> {
        
        
        return getPhotos().map { (photos: [Photo]) -> [Photo] in
            
            return photos.filter{ (photo : Photo) -> Bool in                
                return photo.albumId! == album.id!
            }
        }
        
        
    }
    
}

extension ApiServiceGet {

    func getAlbums() -> Observable<[Album]> {
        
        let path = NSBundle.mainBundle().pathForResource("albums", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        let arrayAlbums : [Album] = Mapper <Album>().mapArray(json)!
        
        return Observable.create { observer in
            observer.onNext(arrayAlbums)
            observer.onCompleted()
            
            return NopDisposable.instance
        }
        
        
        
        }
        
    }
    
    
    func getPhotos () -> Observable<[Photo]> {
        
        let path = NSBundle.mainBundle().pathForResource("photos", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        let arrayPhotos = Mapper <Photo>().mapArray(json)!
        
        return Observable.create { observer in
            observer.onNext(arrayPhotos)
            observer.onCompleted()
            
            return NopDisposable.instance
        }
        
        
        
}



    
    
    func getUsers () -> Observable<[User]> {
        
        let path = NSBundle.mainBundle().pathForResource("users", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        let arrayUsers : [User] = Mapper <User>().mapArray(json)!
        
        return Observable.create { observer in
            observer.onNext(arrayUsers)
            observer.onCompleted()
            
            return NopDisposable.instance
        }
        
        
        
    }



