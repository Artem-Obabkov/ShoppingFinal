//
//  GradientManager.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit

@IBDesignable class GradientManager: UIView {
    
    // Первый цвет градиента
    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet {
            updateGradient()
        }
    }
    
    // Второй цвет градиента
    @IBInspectable var SecondColor: UIColor = UIColor.clear {
        didSet {
            updateGradient()
        }
    }
    
    // Что бы не создавать каждый раз новый слой для градиента мы будем использовать тот, который уже есть
    override class var layerClass : AnyClass {
       return CAGradientLayer.self
    }
    
    // Функция по приминению градиента. Цвета нужно конвертировать в cgColor
    fileprivate func updateGradient() {
        
        let gradientLayer = self.layer as! CAGradientLayer
        
        gradientLayer.colors = [FirstColor.cgColor, SecondColor.cgColor]
        
        // Настраиваем  месторасположение начала и конца градиента. Первый цвет - начало, второй - конец
        gradientLayer.startPoint = CGPoint(x: 0.98, y: -0.2)
        gradientLayer.endPoint = CGPoint(x: 0.15, y: 1)
        
    }
}
