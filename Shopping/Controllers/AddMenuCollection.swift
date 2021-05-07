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
    
    var mainListToShare: MainList?
    
    // EDIT CARD
    
    var indexPathToRecieveAddMenu: IndexPath?
    var editingBegan: Bool = false
    var mainListEditing: MainList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mainListEditing != nil {
            self.textField.text = mainListEditing?.name
        }
        
        setupDesign()
        
        self.textField.delegate = self
        self.textField.becomeFirstResponder()
    }
    
    @IBAction func tfAction(_ sender: UITextField) {
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        
        if editingBegan {
            self.getEditedDataFromAddMenu()
        } else {
            self.getDataFromAddMenu()
        }
        
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func getDataFromAddMenu() {
        
        if self.textField.text != nil && self.textField.text != "" {
            
            let listItem = MainList(name: "\(textField.text!)", isFavourite: false)
            self.mainListToShare = listItem
            performSegue(withIdentifier: "getDataFromAddMenu", sender: nil)
            
        } else {
            
            createAlert(with: "Упс...", message: "Кажется вы ничего не ввели", style: .alert)
        }
    }
    
    func getEditedDataFromAddMenu() {
        
        if self.textField.text != nil && self.textField.text != "" {
            
            try? realm.write {
                mainListEditing?.name = textField.text!
            }
            performSegue(withIdentifier: "getEditedDataFromAddMenu", sender: nil)
            
        } else {
            
            createAlert(with: "Упс...", message: "Кажется вы ничего не ввели", style: .alert)
        }
    }
}


// TEXTFIELD DELEGATE | WORK WITH KEYBOARD

extension AddMenuCollection: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.textField {
            
            if self.editingBegan {
                
                self.getEditedDataFromAddMenu()
                dismiss(animated: true, completion: nil)
                textField.resignFirstResponder()
                
            } else {
                
                self.getDataFromAddMenu()
                dismiss(animated: true, completion: nil)
                textField.resignFirstResponder()
            }
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
