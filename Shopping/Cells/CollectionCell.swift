//
//  CollectionViewCell.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width

class CollectionCell: UICollectionViewCell {

    // Привязать оутлеты
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    let highlightedColor: UIColor = UIColor(named: "RedColorFrom")!

    func setupTextLabel() {
        if screenWidth >= 414 {
            textLabel.numberOfLines = 4
        } else {
            textLabel.numberOfLines = 3
        }
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        print("Action button on collection cell tapped")
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        button.setImage(nil, for: .normal)
        textLabel.text = nil
        setupTextLabel()
    }
}
