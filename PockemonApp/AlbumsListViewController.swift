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
    
    var viewModelAlbumsList : ViewModelAlbumsList?
    
    
    @IBOutlet weak var allAlbumsTabBtn: UITabBarItem!
    
    private(set) var disposeBag = DisposeBag()
    
    @IBOutlet var dataSource: UITableView!
    
    let reuseIdentifier = "albumListCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModelAlbumsList = ViewModelAlbumsList()
        
        
        self.title = "PhotoAlbums"
        
        
        
        setUpViewModel()
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.dataSource.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        viewModelAlbumsList!.setViewModelToStatic ()
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   (viewModelAlbumsList?.albums.value.count)!
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("albumListCell", forIndexPath: indexPath) as! AlbumCell
        
        
        
        cell.changeCellData((viewModelAlbumsList!.viewModelCellsArray.value[indexPath.row]))
        
        viewModelAlbumsList?.viewModelFavouriteAlbumsCollection.value?.getViewModelFavouriteAlbumsData(indexPath.row)
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        viewModelAlbumsList!.cellIndexChanged(indexPath.row)
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if viewModelAlbumsList!.viewModelPhotosCollection.value != nil {
            
            
            let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            
            destinationController.viewModelPhotosCollection = viewModelAlbumsList!.viewModelPhotosCollection.value
        }
        
        
        
    }
    
    
    private func setUpViewModel() {
        
        viewModelAlbumsList?.viewModelCellsArray.asObservable()
            .subscribeNext { (viewModelCells : [ViewModelCell]) in
                self.dataSource.reloadData()
            }.addDisposableTo(disposeBag)
        
        viewModelAlbumsList?.albums.asObservable()
            .subscribeNext { [weak self]( albums : [Album]) in
                self!.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
        ReactiveDataFavouriteAlbums.favouritesCheck.values.toObservable()
            .subscribeNext { [weak self] (switchBoolStates : (Variable <Bool> )) in
                
                
            }.addDisposableTo(disposeBag)
        
        viewModelAlbumsList?.viewModelPhotosCollection.asObservable()
            .filter { $0 != nil }
            .map { $0 }
            
            .subscribeNext { [weak self](viewModelPhotosCollection) in
                
                return (self?.performSegueWithIdentifier("showPhotosIFromAlbum", sender: nil))!
                
            }.addDisposableTo(disposeBag)
        
        
        
        
    }
}
