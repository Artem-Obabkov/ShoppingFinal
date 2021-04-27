//
//  RealmManager.swift
//  Shopping
//
//  Created by pro2017 on 27/04/2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveData(_ list: List) {
        try! realm.write {
            realm.add(list)
        }
    }
}
