//
//  AddMenuTable.swift
//  Shopping
//
//  Created by pro2017 on 07/04/2021.
//

import UIKit
import RealmSwift

// PROTOCOL TO UPDATE PRODUCTS ON TABLEVC IN REAL TIME

protocol AddMenuTVDelegate {
    func passData(item: List<Product>)
}

class AddMenuTable: UIViewController {

    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    // DESIGN
    
    let viewRadius: CGFloat = 25.0
    let buttonRadius: CGFloat = 13.0
    let tfRadius: CGFloat = 12.0
    
    var delegate: AddMenuTVDelegate?
    
    // EDIT PRODUCT
    
    var indexPathToRecieve: IndexPath?
    var productToEdit: Product?
    var editingBegan: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldName.becomeFirstResponder()
        
        if editingBegan && productToEdit != nil {
            
            setupDesignForEditingState()
            
            doneButton.setTitle("Отмена", for: .normal)
            addButton.setTitle("Готово", for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(99)) { [weak self] in
                
                var amount = self?.productToEdit?.amount
                let x = amount?.firstIndex(of: "x")
                amount?.remove(at: x!)
                
                self?.textFieldName.text = self?.productToEdit?.name
                self?.textFieldAmount.text = amount
            }
            
        } else {
            setupDesight()
        }
        
        self.textFieldName.delegate = self
        self.textFieldAmount.delegate = self
        
    }
    
    // WORK WITH TF | LIMIT AMOUNT OF INPUT SYMBOLS
    
    @IBAction func textFieldNameAction(_ sender: UITextField) {
        guard let text: String = textFieldName.text else { return }
        textFieldName.text = String(text.prefix(25))
    }
    

    @IBAction func textFieldAmountAction(_ sender: UITextField) {
        guard let text: String = textFieldAmount.text else { return }
        
        // LIMIT AMOUNT OF INPUT SYMBOLS
        
        if text.contains(".") {
            textFieldAmount.text = String(text.prefix(3))
        } else {
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
            
            if editingBegan {
                
                saveEditedProduct()
            } else {
                
                // SHARE DATA TO TABLEVC IN REAL TIME
                saveProduct(with: amount)
                textFieldName.text = ""
                textFieldAmount.text = ""
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(15)) {
                self.textFieldName.becomeFirstResponder()
            }
            
        } else {
            createAlert(with: "Упс...", message: "Кажется вы ничего не ввели", style: .alert)
        }
        
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // SAVE DATA METHODS 
    
    func saveProduct(with amount: String) {
        
        let product = Product(isSelected: false, name: textFieldName.text!, amount: "x\(amount)")
        let products = List<Product>()
        products.append(product)
        
        // SHARE DATA TO TABLEVC IN REAL TIME
        delegate?.passData(item: products)
    }
    
    
    func saveEditedProduct() {
        
        try? realm.write {
            
            productToEdit?.name = textFieldName.text!
            productToEdit?.amount = "x\(textFieldAmount.text!)"
        }
        
        performSegue(withIdentifier: "GetEditedDataFromAddMenu", sender: nil)
    }

}

// TEXTFIELD DELEGATE | WORK WITH KEYBOARD

extension AddMenuTable: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == self.textFieldName {
            self.textFieldAmount.becomeFirstResponder()
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
