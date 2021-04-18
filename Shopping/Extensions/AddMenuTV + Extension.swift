//
//  AddMenuTV + Extension.swift
//  Shopping
//
//  Created by pro2017 on 10/04/2021.
//

import UIKit

extension AddMenuTable {
    
    func setupDesight() {
        
        addBackgroundGradient(withRadius: viewRadius)
        setupTextFields()
        
        let firstAdd = UIColor(named: "GreenColorTo")!.cgColor
        let secondAdd = UIColor(named: "GreenColorFrom")!.cgColor
        addButton(button: doneButton, withColors: [firstAdd, secondAdd], radius: buttonRadius)
        addButton(button: addButton, withColors: [firstAdd, secondAdd], radius: buttonRadius)
        
    }
    
    func addBackgroundGradient(withRadius radius: CGFloat) {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame.size = addView.frame.size
        
        // Start and end for left to right gradient
        gradientLayer.startPoint = CGPoint(x: 0.98, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.15, y: 1)
        
        let firstBG = UIColor(named: "CardBGGradientTo")!.cgColor
        let secondBG = UIColor(named: "CardBGGradientFrom")!.cgColor
        
        gradientLayer.colors = [firstBG, secondBG]
        gradientLayer.cornerRadius = radius
        
        addView.layer.cornerRadius = radius
        addView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func addButton(button: UIButton, withColors colors: [CGColor], radius: CGFloat) {
        
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame.size = button.frame.size
        
        // Start and end for left to right gradient
        gradientLayer.startPoint = CGPoint(x: 0.98, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.15, y: 1)
        
        let firstBG = colors[0]
        let secondBG = colors[1]
        
        gradientLayer.colors = [firstBG, secondBG]
        gradientLayer.cornerRadius = radius
        
        button.layer.cornerRadius = radius
        button.layer.insertSublayer(gradientLayer, at: 0)
        
    }

    func setupTextFields() {
        
        // First
        textFieldName.layer.cornerRadius = tfRadius
        textFieldName.clipsToBounds = true
        textFieldName.attributedPlaceholder = NSAttributedString(string: "Название продукта...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldPlaceholderColor")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)])
        
        //Second
        textFieldAmount.layer.cornerRadius = tfRadius
        textFieldAmount.clipsToBounds = true
        textFieldAmount.attributedPlaceholder = NSAttributedString(string: "Количество...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldPlaceholderColor")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)])
    }
    
    func createAlert(with mainTitle: String, message: String?, style: UIAlertController.Style) {
        
        let alertVC = UIAlertController(title: mainTitle, message: message, preferredStyle: style)
        
        let doneButton = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        
        alertVC.addAction(doneButton)
        
        present(alertVC, animated: true, completion: nil)
        
    }
}
