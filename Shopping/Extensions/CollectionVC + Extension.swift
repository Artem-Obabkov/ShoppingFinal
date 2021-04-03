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
        //
        return CGSize(width: widthPerItem, height: widthPerItem * 0.97222)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 32, bottom: 22, right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
}

