//
//  ListModel.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit
import RealmSwift

class List: Object {
    
    @objc dynamic var name: String
    @objc dynamic var isFavourite: Bool = false
    @objc dynamic var products: [Product] = [Product]()
    
    init(name: String, isFavourite: Bool){
        self.name = name
        self.isFavourite = isFavourite
    }
    
}
