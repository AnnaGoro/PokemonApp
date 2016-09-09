//
//  AlbumsLikedController.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation

import UIKit
import RxCocoa
import RxSwift

class AlbumsLikedController : UITableViewController {
    
    private(set) var disposeBag = DisposeBag()
    @IBOutlet weak var favouriteAlbuumsTabBtn: UITabBarItem!
    
    @IBOutlet weak var dataSource: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favourite albums"
        
        setUpViewModel()
        
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = ReactiveDataFavouriteAlbums.viewModel.value?.favouriteAlbums.value.count {
            return count
        } else {
            return 0
        }
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "albumListLikedCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! AlbumLikedCell
        cell.changeCellData(ReactiveDataFavouriteAlbums.viewModel.value!.viewModelCellsArray.value[indexPath.row])
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        if segue.identifier == "showPhotosFromFavouriteAlbum" {
            
            let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            
            destinationController.viewModelPhotosCollection = ReactiveDataFavouriteAlbums.viewModel.value!.viewModelPhotosCollection.value
            
        }
        
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        ReactiveDataFavouriteAlbums.viewModel.value!.cellIndexChanged(indexPath.row)
        
    }
    
    private func setUpViewModel() {
        
        ReactiveDataFavouriteAlbums.viewModel.value?.viewModelCellsArray.asObservable()
            
            .subscribeNext { (viewModelCells : [ViewModFavouriteAlbumCell]) in
                
                self.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
        ReactiveDataFavouriteAlbums.favouriteAlbums.asObservable()
            
            .subscribeNext { (albums : [Album]) in
                
                self.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
        
        ReactiveDataFavouriteAlbums.viewModel.value!.albumOwners.asObservable()
            
            .subscribeNext { (users : [User]) in
                
                self.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
        
        ReactiveDataFavouriteAlbums.viewModel.value!.viewModelPhotosCollection.asObservable()
            .filter { $0 != nil }
            .map { $0 }
            
            .subscribeNext { [weak self](viewModelPhotosCollection) in
                return (self?.performSegueWithIdentifier("showPhotosFromFavouriteAlbum", sender: nil))!
            }.addDisposableTo(disposeBag)
        
        
        
    }
    
    
}