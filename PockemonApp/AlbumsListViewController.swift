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
        print("viewDidLoad")
        viewModelAlbumsList = ViewModelAlbumsList()
        
       // ReactiveDataFavouriteAlbums.viewModelAlbums.value = self.viewModelAlbumsList
        
        self.title = "PhotoAlbums"
        
        
            
        setUpViewModel()
        
               allAlbumsTabBtn.badgeValue = String(viewModelAlbumsList?.albums.value.count)
       // self.dataSource.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        print()
        print("viewWillAppear")
        print()
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
        
        cell.number.text = String(viewModelAlbumsList!.albums.value[indexPath.row].id!)
        cell.title.text = viewModelAlbumsList!.albums.value[indexPath.row].title!
        cell.userName.text = viewModelAlbumsList!.users.value[indexPath.row].name!
        
        
        cell.changeSwitchState((ReactiveDataFavouriteAlbums.favouritesCheck.value[indexPath.row]))

        
        cell.switchCheck.rx_value.asObservable().subscribeNext{ [weak self](boolState : Bool) in
            
           // print("switchCheck switchStateChanged cellForRowAtIndexPath in AlbumListViewController")

           self!.viewModelAlbumsList!.switchStateChanged(indexPath.row, checkBoolSwitch : boolState)
           
           
            }.addDisposableTo(cell.disposeBag)
        
         
        
      
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath")
        viewModelAlbumsList!.cellIndexChanged(indexPath.row)

    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    
        print("prepareForSegue")
        //if segue.identifier == "showPhotosIFromAlbum" {
        if viewModelAlbumsList!.viewModelPhotosCollection.value != nil {
        //if !(self.viewModelAlbumsList.viewModelPhotosCollection.value?.photos.value.isEmpty) {
            
            let destinationController = segue.destinationViewController as! PhotosCollectionViewController
            print("destinationController")
             destinationController.viewModelPhotosCollection = viewModelAlbumsList!.viewModelPhotosCollection.value
        }
       // }
        
        
    }
    
    
    private func setUpViewModel() {
        
        viewModelAlbumsList?.albums.asObservable()
            .subscribeNext { [weak self]( albums : [Album]) in
                self!.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
        ReactiveDataFavouriteAlbums.favouritesCheck.asObservable()
            .subscribeNext { [weak self]( switchBoolStates : [Bool]) in
               // self!.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
        viewModelAlbumsList?.viewModelPhotosCollection.asObservable()
            .filter { $0 != nil }
            //.map { $0 }
            
            .subscribeNext { [weak self](viewModelPhotosCollection) in
                return (self?.performSegueWithIdentifier("showPhotosIFromAlbum", sender: nil))!
            }.addDisposableTo(disposeBag)
        

        
    }
}
