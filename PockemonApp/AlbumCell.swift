//
//  CellPokemonCollection.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 29.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class AlbumCell : UITableViewCell {
    
    private var viewModelCell : ViewModelCell?
    
    @IBOutlet weak var switchCheck: UISwitch!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var number: UILabel!
    
    private(set) var disposeBag = DisposeBag()
    
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()        
        super.prepareForReuse()
        
    }
    
    
    @IBAction func changeLike(sender: UISwitch) {
        
        viewModelCell?.likeStatusChanged(switchCheck.on)
        
    }
    
    
    func changeCellData (viewModel : ViewModelCell) {
        
        self.viewModelCell = viewModel
        
        
        self.number.text = String(viewModelCell!.album.id!)
        self.title.text = viewModelCell!.album.title!
        self.userName.text = viewModelCell?.user!.name
        
        self.viewModelCell?.likeStatusObservable.subscribeNext { [weak self] (likeStatus: Bool) in
            
            self?.switchCheck.setOn(likeStatus, animated: false)
            }
            .addDisposableTo(disposeBag)
        
        
    }
    
    
}