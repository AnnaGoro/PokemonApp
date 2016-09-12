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
    
    
    private var favouriteAlbumsViewModel : ViewModelFavouriteAlbums?
    
    private(set) var disposeBag = DisposeBag()
    
    @IBOutlet weak var favouriteAlbuumsTabBtn: UITabBarItem!
    
    @IBOutlet weak var dataSource: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteAlbumsViewModel = ViewModelFavouriteAlbums()
        
        self.title = "Favourite albums"
        
        setUpViewModel()
        
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return (favouriteAlbumsViewModel?.viewModelCellsArray.value.count)!
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "albumListCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! AlbumCell
      
        cell.changeCellData((favouriteAlbumsViewModel!.viewModelCellsArray.value[indexPath.row]))
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        if segue.identifier == "showPhotosFromFavouriteAlbum" {
            
            let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            
           
        }
        
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    private func setUpViewModel() {
        
        favouriteAlbumsViewModel?.viewModelCellsArray.asObservable()
            .subscribeNext { (viewModelCells : [ViewModelCell]) in
                self.dataSource.reloadData()
            }.addDisposableTo(disposeBag)
    
        favouriteAlbumsViewModel?.viewModelPhotosCollection.asObservable()
            .filter { $0 != nil }
            .map { $0 }
            
            .subscribeNext { [weak self](viewModelPhotosCollection) in
                
                return (self?.performSegueWithIdentifier("showPhotosIFromAlbum", sender: nil))!
                
            }.addDisposableTo(disposeBag)
        
        

       
        
        
    }
    
    
}