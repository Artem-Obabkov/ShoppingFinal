//
//  CollectionVC + Extension.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit

// Работа с ячейкой
extension CollectionVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var colViewSize: CGFloat = 0
        
        if Int(collectionView.frame.width) % 2 == 0 {
            colViewSize = collectionView.frame.width
        } else {
            colViewSize = collectionView.frame.width - 1
        }
        
        let paddingWidth = (edgeSpacing * 2) + interItemSpacing
        let aviableWidth = colViewSize - paddingWidth
        let widthPerItem = aviableWidth / itemsPerRow
        self.widthPerItem = widthPerItem
        //
        return CGSize(width: widthPerItem, height: widthPerItem * 0.97222)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if mainList.count == 1 {
            var leftInset: CGFloat = 0
            let halfScreen: CGFloat = collectionView.frame.width / 2
            
            leftInset = -(halfScreen) + 22
            
            return UIEdgeInsets(top: 22, left: leftInset, bottom: 22, right: 0)
        }
        
        return UIEdgeInsets(top: 22, left: 32, bottom: 22, right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    // Design
    
    func addBackgroundGradient() {
        
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame.size = view.frame.size
        
        // Start and end for left to right gradient
        gradientLayer.startPoint = CGPoint(x: 0.98, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.15, y: 1)
        
        let firstBG = UIColor(named: "BGGradientTo")!.cgColor
        let secondBG = UIColor(named: "BGGradientFrom")!.cgColor
        
        gradientLayer.colors = [firstBG, secondBG]
                
        collectionView.backgroundView = collectionViewBackgroundView
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    
    func setupNavigationBarDesign() {
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 13.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        // Navigation bar design
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor(named: "TextColorMain")!]
    }
}

