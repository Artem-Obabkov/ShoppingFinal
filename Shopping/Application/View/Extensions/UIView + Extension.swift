//
//  UIView + Extension.swift
//  Shopping
//
//  Created by pro2017 on 17/04/2021.
//

import UIKit

extension UIView {
    
    func addShadow(to edges: [UIRectEdge], radius: CGFloat = 3.0, opacity: Float = 0.6, color: CGColor = UIColor.black.cgColor, insets: (x: CGFloat, y: CGFloat) = (x: 0, y: 0)) {
        
        let fromColor = color
        let toColor = UIColor.clear.cgColor
        //let viewWithCorners = self.layer.cornerRadius
        let viewFrame = self.frame
        
        
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity
            gradientLayer.shadowRadius = radius / 3

            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius + insets.y)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius - insets.y)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius + insets.x, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius - insets.x, height: viewFrame.height)
            default:
                break
            }
            
            self.layer.addSublayer(gradientLayer)
            
        }
    }

    func removeAllShadows() {
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers {
                if (sublayer is CAGradientLayer) {
                    sublayer.removeFromSuperlayer()
                }
            }
        }
    }
}
