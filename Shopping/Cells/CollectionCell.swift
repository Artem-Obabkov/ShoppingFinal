//
//  CollectionViewCell.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit



protocol CollectionCellDelegate {
    func cardAction(cell: CollectionCell, card: MainList, indexPath: IndexPath)
}

class CollectionCell: UICollectionViewCell {

    // Привязать оутлеты
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    var card: MainList?
    var indexPath: IndexPath?
    // Передача данных с помощью делегирования
    var delegate: CollectionCellDelegate?
    
    
    let highlightedColor: UIColor = UIColor(named: "RedColorFrom")!

    func setupTextLabel() {
        if screenWidth >= 414 {
            textLabel.numberOfLines = 4
        } else {
            textLabel.numberOfLines = 3
        }
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        if var card = card, let indexPath = indexPath {
            
            try? realm.write {
                card.isFavourite.toggle()
            }
            
            self.delegate?.cardAction(cell: self, card: card, indexPath: indexPath)
        }
    }
    
}
