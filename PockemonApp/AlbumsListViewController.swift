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

class AlbumsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let viewModelAlbumsList = ViewModelAlbumsList()
    let viewModelPhotoCollection = ViewModelPhotosCollection()
    
    let reuseIdentifier = "albumListCell"
    
    var searchBar : UISearchController!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var dataSource: UITableView!
    
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PhotoAlbums"
        
        setUpViewModel()
        
        
    }

    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   viewModelAlbumsList.albums.value.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "albumListCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! AlbumCell
        
        cell.number.text = String(viewModelAlbumsList.albums.value[indexPath.row].id!)
        cell.title.text = viewModelAlbumsList.albums.value[indexPath.row].title!
        
       
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
        print ("******************")
        print(indexPath.row)
        
        viewModelPhotoCollection.album.value = viewModelAlbumsList.albums.value[(indexPath.item)]
    }
    
    private func setUpViewModel() {
    
     
        viewModelAlbumsList.albums.asObservable().subscribeNext { ( albums : [Album]) in
            
            self.dataSource.reloadData()
          
            
        }.addDisposableTo(disposeBag)
    
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let selectedIndex = self.dataSource.indexPathForCell(sender as! UITableViewCell)
        print(selectedIndex?.item)
        print ("******************")
        print(selectedIndex?.row)
        if segue.identifier == "showPhotosIFromAlbum" {
            if let destinationVC = segue.destinationViewController as? PhotosCollectionViewController {
                
              // var viewModelPhotosCollection = ViewModelPhotosCollection(viewModelAlbumsList.albums.value[(selectedIndex?.item)!])
                //destinationVC.titleAlbum = viewModelAlbumsList.albums.value[(selectedIndex?.item)!].title!
                viewModelPhotoCollection.album.value = viewModelAlbumsList.albums.value[(selectedIndex?.item)!]
           }
    }
 
    
}
}
