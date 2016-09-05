//
//  ViewController.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class AlbumsListViewController: UITableViewController  {
    
    var viewModelAlbumsList = ViewModelAlbumsList()
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet var dataSource: UITableView!
    
    let reuseIdentifier = "albumListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
     
        self.clearsSelectionOnViewWillAppear = false
        
        self.title = "PhotoAlbums"
        
        setUpViewModel()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   viewModelAlbumsList.albums.value.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "albumListCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! AlbumCell
        
        cell.number.text = String(viewModelAlbumsList.albums.value[indexPath.row].id!)
        cell.title.text = viewModelAlbumsList.albums.value[indexPath.row].title!
        cell.userName.text = viewModelAlbumsList.users.value[indexPath.row].name!
    
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
 
        
        self.viewModelAlbumsList.switchRac =  cell.switchCheck.rx_value.asObservable()
        
        
        viewModelAlbumsList.favouritesCheck.asObservable()
            
            .subscribeNext {( checks : [Bool]) in
                
                
            }.addDisposableTo(disposeBag)
        
   
             return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.viewModelAlbumsList.cellIndexChanged(indexPath.row)

    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    

        if segue.identifier == "showPhotosIFromAlbum" {
            
            let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            
             destinationController.viewModelPhotosCollection = self.viewModelAlbumsList.viewModelPhotosCollection.value
       
        }
        
        
    }
    
    
    private func setUpViewModel() {
        
        viewModelAlbumsList.albums.asObservable()
            .subscribeNext { [weak self]( albums : [Album]) in
                self!.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
        viewModelAlbumsList.viewModelPhotosCollection.asObservable()
            .filter { (album) -> Bool in
                return album != nil
            }
            .subscribeNext { [weak self](viewModelPhotosCollection) in
                //print("album != nil and performSegueWithIdentifier showPhotosIFromAlbum")
                return (self?.performSegueWithIdentifier("showPhotosIFromAlbum", sender: nil))!
            }.addDisposableTo(disposeBag)
        
        
    }
    
   /*
    
    func sendDataToFavouriteAlbums() {
    
    
        let destinationController =  as! AlbumsLikedController
        
        destinationController.viewModelFavouriteAlbumsCollection = self.viewModelAlbumsList.viewModelFavouriteAlbumsCollection.value
        
    
    
    
    }
 
 */

}
