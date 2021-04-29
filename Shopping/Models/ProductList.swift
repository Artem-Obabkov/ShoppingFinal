//
//  ProductList.swift
//  Shopping
//
//  Created by pro2017 on 07/04/2021.
//

import RealmSwift


class Product: Object {
    @objc dynamic var isSelected: Bool = false
    @objc dynamic var name: String = ""
    @objc dynamic var amount: String = ""
    
    convenience init(isSelected: Bool, name: String, amount: String) {
        self.init()
        self.isSelected = isSelected
        self.name = name
        self.amount = amount
    }
}
