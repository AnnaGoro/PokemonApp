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
    private let apiService = ApiService()
    @IBOutlet weak var collectionDataSource: UICollectionView!
    
    let reuseIdentifier = "pokemonCell"
    
    var searchBar : UISearchController!
    let disposeBag = DisposeBag()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.getPokemonsForPreview (10)
            .subscribe(
                
                onNext: {(pokemons : [Pokemon]) in
                    
                    for pokemon in pokemons{
                    
                    
                        print(pokemon.id)
                        print(pokemon.name)
                        print(pokemon.imageUrl?.iUrl)
                  
                    }
                },
                onError: { error in
                    print("Error!!")
                }
        )
        

/*
        
        apiService.getPokemonsFromAllRacs(10)
        
           .subscribe(
                
                onNext: { (pokemons : [Pokemon]) in
                    
                    for pokemon in pokemons{
                        
                        print(pokemon.id)
                        print(pokemon.name)
                        print(pokemon.weight)
                        print(pokemon.height)
                        print(pokemon.abilities?.first?.abilityName?.name)
                        print(pokemon.types?.first?.type?.name)
                        print(pokemon.imageUrl?.iUrl)
                        print("***********************")
                        
                    }
                    
                },
                onError: { error in
                    print("Error!!")
                }
        )
        
       */ 
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CellPokemonCollection
        
        
        return cell
    }
    
   
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
   /*
    
    private func setupBindings() {
        // ...
        
        viewModelPokemon.pokemons!
            .bindTo(collectionDataSource.rx_itemsWithCellIdentifier(reuseIdentifier, cellType: CellPokemonCollection.self)) { (row, element, cell) in
                cell.viewModelPokemon = ViewModelPokemon (model: element)
                
            }
            .addDisposableTo(disposeBag)
    }
        /*
        
        }
             let cell: CellPokemonCollection = collectionDataSource.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: 
         //<#T##NSIndexPath#>)
               
                
                return cell
            }
            .addDisposableTo(disposeBag)
    }
    

*/
 */

}

