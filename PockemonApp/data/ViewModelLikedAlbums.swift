//
//  viewModelLikedAlbums.swift
//  PockemonApp
//
//  Created by Anna Gorobchenko on 31.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModelLikedAlbums {
    
    
    let title : Variable <String> = Variable( "" )
    let userName : Variable <String> = Variable( "" )
    let id : Variable <String> = Variable( "" )
    
    private let apiService = ApiService()
    private let bag = DisposeBag()
    

    
    
}