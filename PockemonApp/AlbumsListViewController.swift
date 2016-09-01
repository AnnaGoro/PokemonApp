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
    
    
    private func setUpViewModel() {
    
     
        viewModelAlbumsList.albums.asObservable().subscribeNext { ( albums : [Album]) in
            
            self.dataSource.reloadData()
            
        }.addDisposableTo(disposeBag)
    
        
    }
    
    
}

