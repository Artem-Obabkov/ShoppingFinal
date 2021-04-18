//
//  AddMenuCV + Extension.swift
//  Shopping
//
//  Created by pro2017 on 10/04/2021.
//

import UIKit

extension AddMenuCollection {
    
    func setupDesign() {
        
        
        textField.layer.cornerRadius = tfRadius
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "Куда идете...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldPlaceholderColor")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)])
        
        viewGradient(withRadius: viewRadius)
        
        let firstCancel = UIColor(named: "RedColorTo")!.cgColor
        let secondCancel = UIColor(named: "RedColorFrom")!.cgColor
        buttonGradient(button: cancelButton, withColors: [firstCancel, secondCancel], radius: buttonRadius)
        
        let firstAdd = UIColor(named: "GreenColorTo")!.cgColor
        let secondAdd = UIColor(named: "GreenColorFrom")!.cgColor
        buttonGradient(button: addButton, withColors: [firstAdd, secondAdd], radius: buttonRadius)
        
    }
    
    func viewGradient(withRadius radius: CGFloat) {
        
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
    
    func buttonGradient(button: UIButton, withColors colors: [CGColor], radius: CGFloat) {
        
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
    
    func createAlert(with mainTitle: String, message: String?, style: UIAlertController.Style) {
        
        let alertVC = UIAlertController(title: mainTitle, message: message, preferredStyle: style)
        alertVC.overrideUserInterfaceStyle = .dark
        
        let doneButton = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        
        alertVC.addAction(doneButton)
        
        present(alertVC, animated: true, completion: nil)
        
    }
    
}
