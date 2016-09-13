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
    
    var dataSourceTable: RxTableViewSectionedAnimatedDataSource<SectionOfData>?
    
    @IBOutlet weak var allAlbumsTabBtn: UITabBarItem!
    
    private(set) var disposeBag = DisposeBag()
    
    @IBOutlet var dataSource: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModelAlbumsList = ViewModelAlbumsList()
        
        self.title = "PhotoAlbums"
        
        setUpViewModel()
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   (viewModelAlbumsList?.sections.value.first?.items.count)!
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if viewModelAlbumsList!.viewModelPhotosCollection.value != nil {
            
            let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            destinationController.viewModelPhotosCollection = viewModelAlbumsList!.viewModelPhotosCollection.value
        }
        
    }
    
    
    private func setUpViewModel() {
        
        self.dataSource.delegate = nil
        self.dataSource.dataSource = nil
        
        dataSource
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)

        
        let dataSourceTable = RxTableViewSectionedAnimatedDataSource<SectionOfData>()
        
        viewModelAlbumsList?.sections.asObservable()
            
            .bindTo(dataSource.rx_itemsWithDataSource(dataSourceTable))
            
            .addDisposableTo(disposeBag)
        
        
        dataSourceTable.configureCell = { dataSource, tableView, indexPath, cellViewModel in
            
            let cell = tableView.dequeueReusableCellWithIdentifier("albumListCell", forIndexPath: indexPath) as! AlbumCell
            
            cell.changeCellData(cellViewModel)
            
            return cell
        }
        
        
        dataSource.rx_itemSelected.subscribeNext { (indexPath) in
            
            self.viewModelAlbumsList!.cellIndexChanged(indexPath.row)
            
            self.performSegueWithIdentifier("showPhotosIFromAlbum", sender: indexPath)
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }.addDisposableTo(disposeBag)
        
         self.dataSourceTable = dataSourceTable
        
    }
}
