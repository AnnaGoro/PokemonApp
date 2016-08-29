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

class PokemonCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let vieModelPokemon = ViewModelPokemon()
    var pokemons: Variable<[ViewModelPokemon]>?

    @IBOutlet weak var collectionDataSource: UICollectionView!
    
    var searchBar : UISearchController!
    let disposeBag = DisposeBag()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Int>>()
        
        Observable.just([SectionModel(model: "title", items: [1, 2, 3])])
        
            .bindTo(collectionDataSource.rx_setDataSource(dataSource))
     
             collectionDataSource
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
            collectionDataSource.rx_scrollEnabled
        
            self.collectionDataSource.reloadData()
            
        
        }
        
        
    

        let reuseIdentifier = "pokemonCell"
    
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CellPokemonCollection
        
      _ = vieModelPokemon.name.asObservable().bindTo(cell.name.rx_text).addDisposableTo(disposeBag)
      _ = vieModelPokemon.weight.asObservable().bindTo(cell.weight.rx_text)
        
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

