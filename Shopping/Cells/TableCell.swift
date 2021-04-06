//
//  TableCell.swift
//  Shopping
//
//  Created by pro2017 on 04/04/2021.
//

import UIKit

class TableCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
    }
    

}
