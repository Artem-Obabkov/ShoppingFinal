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
    
    var addItem: ((List) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
    }
    
    @IBAction func tfAction(_ sender: UITextField) {
        
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        
        if textField.text != nil && textField.text != "" {
            performSegue(withIdentifier: "getDataFromAddMenu", sender: nil)
            dismiss(animated: true, completion: nil)
            
        } else {
            createAlert(with: "Упс...", message: "Кажется вы ничего не ввели", style: .alert)
        }
        
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
