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
        
        self.dataSource.delegate = self
        self.dataSource.dataSource = self
     
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
        
        self.viewModelAlbumsList.switchRac =  cell.switchCheck.rx_value.asObservable()
        
             //viewModel.creativeCommons.bidirectionalBindTo(creativeCommonsSwitch.bnd_on)
        //self.viewModelAlbumsList.switchPac.bidirectionalBindTo(cell.switchCheck.bnd_on)
        
        //self.viewModelAlbumsList.switchRac =
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //cell.switchCheck.setOn(false, animated: true)
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.viewModelAlbumsList.cellIndexChanged(indexPath.row)
        
       // self.viewModelAlbumsList.indexPathCellRac = Observable.just(indexPath.row)
        
        //self.performSegueWithIdentifier("showPhotosIFromAlbum", sender: nil)
        
        print("didSelectRowAtIndexPath \(indexPath.row)")
        
    }
    

    
    private func setUpViewModel() {
        
        viewModelAlbumsList.albums.asObservable()
            .subscribeNext { [weak self]( albums : [Album]) in
                self!.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
        viewModelAlbumsList.viewModelPhotosCollection.asObservable()
            .filter {[weak self](album) -> Bool in
                return album != nil
            }.subscribeNext { [weak self](viewModelPhotosCollection) in
                self!.performSegueWithIdentifier("showPhotosIFromAlbum", sender: nil)
            }.addDisposableTo(disposeBag)

        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
       // let selectedIndex = self.dataSource.indexPathForCell(sender as! UITableViewCell)
        
       // self.viewModelAlbumsList.indexPathCellRac = Observable.just((selectedIndex?.row)!)
        
       // guard self.viewModelAlbumsList.viewModelPhotosCollection.value != nil else {
          //  return
       // }

       // if segue.identifier == "showPhotosIFromAlbum" {
            
            let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            
             destinationController.viewModelPhotosCollection = self.viewModelAlbumsList.viewModelPhotosCollection.value
            
       // }
        
        
    }
}
