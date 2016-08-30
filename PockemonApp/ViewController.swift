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

class PokemonCollectionViewController: UIViewController, UICollectionViewDataSource {
    private let vieModelPokemon = ViewModelPokemon()
    var pokemons: Variable<[ViewModelPokemon]>?

    @IBOutlet weak var collectionDataSource: UICollectionView!
    
    var searchBar : UISearchController!
    let disposeBag = DisposeBag()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Int>>()
        
        
            self.collectionDataSource.reloadData()
            
        
        }
        

        let reuseIdentifier = "pokemonCell"
    
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CellPokemonCollection
        
     
        if let cell = cell as? CellPokemonCollection {
            cell.name.text = vieModelPokemon.modelName.value
            cell.weight.text = vieModelPokemon.modelWeight.value
        }
        
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
    
    
    
    
    
    
    /*
    
    private func setupBindings() {
        // ...
        
        vieModelPokemon.observableApiGetPokemons!.bindTo(collectionDataSource.rx_itemsWithCellFactory) { collectionView, index, border in
                let cell: CellPokemonCollection = collectionView.cellForItemAtIndexPath(index)
                //cell.border = border
                
                return cell
            }
            .addDisposableTo(disposeBag)
    }
    */

}

