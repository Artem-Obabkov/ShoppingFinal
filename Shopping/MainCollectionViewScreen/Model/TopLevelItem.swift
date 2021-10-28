//
//  TopLevelItem.swift
//  Shopping
//
//  Created by pro2017 on 29/04/2021.
//

import Foundation
import RealmSwift

class TopLevelItem: Object {
    var mainList = List<MainList>()
}
