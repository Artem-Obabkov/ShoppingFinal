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
        
        self.textFieldName.delegate = self
        self.textFieldAmount.delegate = self
    }
    
    @IBAction func textFieldNameAction(_ sender: UITextField) {
        guard let text: String = textFieldName.text else { return }
        textFieldName.text = String(text.prefix(25))
    }
    

    @IBAction func textFieldAmountAction(_ sender: UITextField) {
        guard let text: String = textFieldAmount.text else { return }
        
        // Ограничиваем количество символов для ввода
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
            
            let product = Product(name: textFieldName.text!, amount: "x\(amount)")
            
            // Передаем данные на TableVC в реальном времени
            delegate?.passData(item: product)
            
            textFieldName.text = ""
            textFieldAmount.text = ""
            
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

}

// TEXTFIELD DELEGATE | WORK WITH KEYBOARD

extension AddMenuTable: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == self.textFieldName {
            //print("Hello")
            self.textFieldAmount.becomeFirstResponder()
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
