//
//  UIAlertAction + Extension.swift
//  Shopping
//
//  Created by pro2017 on 18/04/2021.
//

import UIKit

extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
