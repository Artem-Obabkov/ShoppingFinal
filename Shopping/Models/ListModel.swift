//
//  ListModel.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit

struct List {
    
    var name: String
    var isFavourite: Bool = false
    var products: [Product] = [Product]()
    
    init(name: String, isFavourite: Bool){
        self.name = name
        self.isFavourite = isFavourite
    }
    
}
