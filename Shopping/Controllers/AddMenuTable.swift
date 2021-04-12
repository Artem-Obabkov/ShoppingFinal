//
//  AddMenuTable.swift
//  Shopping
//
//  Created by pro2017 on 07/04/2021.
//

import UIKit

protocol AddMenuTVDelegate {
    func passData(item: Product)
}

class AddMenuTable: UIViewController {

    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    let viewRadius: CGFloat = 25.0
    let buttonRadius: CGFloat = 13.0
    let tfRadius: CGFloat = 12.0
    
    var delegate: AddMenuTVDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesight()
    }
    
    
    @IBAction func textFieldNameAction(_ sender: UITextField) {
        
    }
    

    @IBAction func textFieldAmountAction(_ sender: UITextField) {
        // Ограничиваем количество символов для ввода
        if let text: String = textFieldAmount.text {
            textFieldAmount.text = String(text.prefix(2))
        }
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        
        if textFieldName.text != nil && textFieldName.text != "" {
            
            var amount = ""
            
            if textFieldAmount.text == nil || textFieldAmount.text == "" {
                amount = "1"
            }  else {
                amount = textFieldAmount.text!
            }
            
            let product = Product(name: textFieldName.text!, amount: "x\(amount)")
            
            delegate?.passData(item: product)
            
            textFieldName.text = ""
            textFieldAmount.text = ""
            
        } else {
            createAlert(with: "Упс...", message: "Кажется вы ничего не ввели", style: .alert)
        }
        
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

