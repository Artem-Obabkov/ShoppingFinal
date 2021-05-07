//
//  RealmManager.swift
//  Shopping
//
//  Created by pro2017 on 27/04/2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveData(_ item: TopLevelItem) {
        try! realm.write {
            realm.add(item)
        }
    }
    static func deleteData(_ item: TopLevelItem) {
        try! realm.write {
            realm.delete(item)
        }
    }
}
