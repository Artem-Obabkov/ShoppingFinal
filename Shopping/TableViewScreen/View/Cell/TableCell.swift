//
//  TableCell.swift
//  Shopping
//
//  Created by pro2017 on 04/04/2021.
//

import UIKit

// PROTOCOL TO CHANGE isSelected IN REAL TIME

protocol TableCellDelegate {
    func productAction(cell: TableCell, product: Product, indexPath: IndexPath)
}

class TableCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var product: Product?
    var indexPath: IndexPath?
    
    // PASS DATA BY USING DELEGATE
    var delegate: TableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if let product = product, let indexPath = indexPath {
            
            try? realm.write {
                product.isSelected.toggle()
            }
            
            self.delegate?.productAction(cell: self, product: product, indexPath: indexPath)
        }
    }
}
