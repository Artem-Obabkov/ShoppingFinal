//
//  ListModel.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit
import RealmSwift

class MainList: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var isFavourite: Bool = false
    var products = List<Product>()
    
    convenience init(name: String, isFavourite: Bool){
        self.init()
        self.name = name
        self.isFavourite = isFavourite
    }
    
}
