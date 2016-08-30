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
    private let viewModelPokemon = ViewModelPokemon()
   // var pokemons: Variable<[ViewModelPokemon]>?

    @IBOutlet weak var collectionDataSource: UICollectionView!
    
    var searchBar : UISearchController!
    let disposeBag = DisposeBag()
    


    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        viewModelPokemon.pokemons!
            .subscribe(onNext : { result in
                print (result?.name)
            })
        
        }
        

        let reuseIdentifier = "pokemonCell"
    
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CellPokemonCollection
        
        
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
    
    
    func setupCell(row: Int, element: Pokemon, cell: CellPokemonCollection){
        cell.name.text = element.name
        cell.weight.text = element.weight
    
    }
   /*
    
    private func setupBindings() {
        // ...
        
        viewModelPokemon.pokemons!
            .bindTo(collectionDataSource.rx)
             let cell: CellPokemonCollection = collectionView.dequeueReusableCell()
               
                
                return cell
            }
            .addDisposableTo(disposeBag)
    }
    
    */
    

}

