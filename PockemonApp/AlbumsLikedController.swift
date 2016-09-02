//
//  AlbumsLikedController.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation

import UIKit

class AlbumsLikedController : UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var dataSource: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favourite albums"
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "albumListLikedCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! AlbumLikedCell
        
        
        
        
        
        return cell
    }


}