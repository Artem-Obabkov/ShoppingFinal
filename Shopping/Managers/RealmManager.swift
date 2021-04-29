//
//  RealmManager.swift
//  Shopping
//
//  Created by pro2017 on 27/04/2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveData(_ list: MainList) {
        try! realm.write {
            realm.add(list)
        }
    }
    static func deleteData(_ list: MainList) {
        try! realm.write {
            realm.delete(list)
        }
    }
}
