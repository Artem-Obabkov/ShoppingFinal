//
//  CollectionViewCell.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit

// PROTOCOL TO CHANGE isFavourite IN REAL TIME

protocol CollectionCellDelegate {
    func cardAction(cell: CollectionCell, card: MainList, indexPath: IndexPath)
}

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    
    var card: MainList?
    var indexPath: IndexPath?
    
    // PASS DATA BY USING DELEGATE
    var delegate: CollectionCellDelegate?
    
    
    //let highlightedColor: UIColor = UIColor(named: "RedColorFrom")!
    
    func setupAmountOfRowsInTF() {
        if screenWidth >= 414 {
            textLabel.numberOfLines = 4
        } else {
            textLabel.numberOfLines = 3
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if let card = card, let indexPath = indexPath {
            
            try? realm.write {
                card.isFavourite.toggle()
            }
            
            if card.isFavourite {
                UIView.animate(withDuration: 0.15) {
                    self.alpha = 0
                    print(card.isFavourite)
                }
            } else {
                UIView.animate(withDuration: 0.15) {
                    self.alpha = 1
                }
            }
            self.delegate?.cardAction(cell: self, card: card, indexPath: indexPath)
        }
    }
    
}
