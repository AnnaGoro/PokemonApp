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
    
    var viewModelAlbumsList = ViewModelAlbumsList()
    var viewModelPhotoCollection : ViewModelPhotosCollection?
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet var dataSource: UITableView!
    let reuseIdentifier = "albumListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PhotoAlbums"
        viewModelPhotoCollection = viewModelAlbumsList.viewModelPhotosCollection
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
        cell.userName.text = viewModelAlbumsList.users.value[indexPath.row].name!
        
        return cell
    }
    
    
    private func setUpViewModel() {
        
        viewModelAlbumsList.albums.asObservable()
            .subscribeNext { [weak self]( albums : [Album]) in
            self!.dataSource.reloadData()
            
            }.addDisposableTo(disposeBag)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let selectedIndex = self.dataSource.indexPathForCell(sender as! UITableViewCell)
        
        viewModelPhotoCollection!.album.value = viewModelAlbumsList.albums.value[(selectedIndex?.item)!]
        if segue.identifier == "showPhotosIFromAlbum" {
           let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            
            destinationController.viewModelPhotosCollection = viewModelPhotoCollection
            
        }
        
        
    }
}
