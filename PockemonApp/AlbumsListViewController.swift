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
  
    private let apiService = ApiService()
     
    let reuseIdentifier = "albumListCell"
    
    var searchBar : UISearchController!
    let disposeBag = DisposeBag()
    
    @IBOutlet var dataSource: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        

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

    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "albumListCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! AlbumCell
        
        
        Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
//            .flatMapLatest { (urls : String) -> Observable<Int> in
//                
//                return Observable.just(Int(urls)!)
//                
//            }
//            .shareReplayLatestWhileConnected()
            .subscribeNext { (a: Int) in
                print()
            }
        
        
        
        
        
        
        
        
        
        return cell
    }
   /*
    
    private func setupBindings() {
        // ...
        
        viewModel.pokemons!
            .bindTo(dataSource.rx_itemsWithCellIdentifier(reuseIdentifier, cellType: AlbumCell.self)) { (row, element, cell) in
               
                
            }
            .addDisposableTo(disposeBag)
    }
     
        
        }
             let cell: CellPokemonCollection = collectionDataSource.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: 
         //<#T##NSIndexPath#>)
               
                
                return cell
            }
            .addDisposableTo(disposeBag)
    }
    


 */

}

