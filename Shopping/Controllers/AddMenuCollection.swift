//
//  AddMenuCollection.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit

class AddMenuCollection: UIViewController {

    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let viewRadius: CGFloat = 25.0
    let buttonRadius: CGFloat = 13.0
    let tfRadius: CGFloat = 12.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        
        self.textField.delegate = self
        self.textField.becomeFirstResponder()
    }
    
    @IBAction func tfAction(_ sender: UITextField) {
        
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        
        performSegue(withIdentifier: "getDataFromAddMenu", sender: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveData() {
        
        if self.textField.text != nil && self.textField.text != "" {
            
            let listItem = MainList(name: "\(textField.text!)", isFavourite: false)
            StorageManager.saveData(listItem)
            
        } else {
            
            createAlert(with: "Упс...", message: "Кажется вы ничего не ввели", style: .alert)
        }
    }
}


// TEXTFIELD DELEGATE | WORK WITH KEYBOARD

extension AddMenuCollection: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.textField {
            performSegue(withIdentifier: "getDataFromAddMenu", sender: nil)
            dismiss(animated: true, completion: nil)
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
