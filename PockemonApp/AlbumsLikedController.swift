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
import RxDataSources


class AlbumsLikedController : UITableViewController {
    
    private var favouriteAlbumsViewModel : ViewModelFavouriteAlbums?
    
    private(set) var disposeBag = DisposeBag()
    
    @IBOutlet weak var favouriteAlbuumsTabBtn: UITabBarItem!
    
    @IBOutlet weak var dataSource: UITableView!
    var dataSourceTable: RxTableViewSectionedAnimatedDataSource<SectionOfData>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteAlbumsViewModel = ViewModelFavouriteAlbums()
        
        self.title = "Favourite albums"
        
        setUpViewModel()
        
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (favouriteAlbumsViewModel?.sections.value.first!.items.count)!
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        if segue.identifier == "showPhotosIFromAlbum" {
            
            let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            destinationController.viewModelPhotosCollection = favouriteAlbumsViewModel?.viewModelPhotosCollection.value
            
        }
        
    }
    
    
    private func setUpViewModel() {
        
        self.dataSource.delegate = nil
        self.dataSource.dataSource = nil
        
        dataSource
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
        
        let dataSourceTable = RxTableViewSectionedAnimatedDataSource<SectionOfData>()
        
        favouriteAlbumsViewModel?.sections.asObservable()
            
            .bindTo(dataSource.rx_itemsWithDataSource(dataSourceTable))
            
            .addDisposableTo(disposeBag)
        
        
        dataSourceTable.configureCell = { [weak self] (dataSource, tableView, indexPath, cellViewModel) in
            
            let cell = tableView.dequeueReusableCellWithIdentifier("albumListCell", forIndexPath: indexPath) as! AlbumCell
            
            cell.changeCellData(cellViewModel)
            
            return cell
        }
        
        
        dataSource.rx_itemSelected.subscribeNext { (indexPath) in
            
            self.favouriteAlbumsViewModel!.cellIndexChanged(indexPath.row)
            
            self.performSegueWithIdentifier("showPhotosIFromAlbum", sender: indexPath)
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }.addDisposableTo(disposeBag)
        
        self.dataSourceTable = dataSourceTable
        
    }
    
    
}