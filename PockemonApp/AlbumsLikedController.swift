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
    
    var viewModelFavouriteAlbums : ViewModelFavouriteAlbums?
    private(set) var disposeBag = DisposeBag()
    
    @IBOutlet weak var dataSource: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favourite albums"
        
        setUpViewModel()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = ReactiveDataFavouriteAlbums.viewModel.value?.favouriteAlbums.value.count {
            return count
            print(count)
        } else {
            print("count = 0")
            return 5
        }
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "albumListLikedCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! AlbumLikedCell
        
        cell.numberLabel.text = String(ReactiveDataFavouriteAlbums.viewModel.value!.favouriteAlbums.value[indexPath.row].id!)
        print((ReactiveDataFavouriteAlbums.viewModel.value!.favouriteAlbums.value[indexPath.row].id!))
        
        cell.titleLabel.text = ReactiveDataFavouriteAlbums.viewModel.value!.favouriteAlbums.value[indexPath.row].title!
        print(ReactiveDataFavouriteAlbums.viewModel.value!.favouriteAlbums.value[indexPath.row].title!)
        
        cell.userNameLabel.text = ReactiveDataFavouriteAlbums.viewModel.value!.users.value[indexPath.row].name!
        print(ReactiveDataFavouriteAlbums.viewModel.value!.users.value[indexPath.row].name!)
        
        cell.switchLike.setOn(true, animated: false)
        
        return cell
    }

    private func setUpViewModel() {
        
        print ("***********************")
        
        print(ReactiveDataFavouriteAlbums.viewModel.value!.favouriteAlbums.value)
        ReactiveDataFavouriteAlbums.viewModel.value!.favouriteAlbums.asObservable()
            
            .subscribeNext {[weak self] (albums : [Album]) in
             
                self!.dataSource.reloadData()
                
            }.addDisposableTo(disposeBag)
        
    }
    

}