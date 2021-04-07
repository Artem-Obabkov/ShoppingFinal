//
//  AddMenuTable.swift
//  Shopping
//
//  Created by pro2017 on 07/04/2021.
//

import UIKit

class AddMenuTable: UIViewController {

    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    let viewRadius: CGFloat = 25.0
    let buttonRadius: CGFloat = 13.0
    let tfRadius: CGFloat = 12.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesight()
    }
    
    
    @IBAction func textFieldNameAction(_ sender: UITextField) {
    }
    
    @IBAction func textFieldAmountAction(_ sender: UITextField) {
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate func setupDesight() {
        
        addBackgroundGradient(withRadius: viewRadius)
        setupTextFields()
        
        let firstAdd = UIColor(named: "GreenColorTo")!.cgColor
        let secondAdd = UIColor(named: "GreenColorFrom")!.cgColor
        addButton(button: doneButton, withColors: [firstAdd, secondAdd], radius: buttonRadius)
        addButton(button: addButton, withColors: [firstAdd, secondAdd], radius: buttonRadius)
        
    }
    
    fileprivate func addBackgroundGradient(withRadius radius: CGFloat) {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame.size = addView.frame.size
        
        // Start and end for left to right gradient
        gradientLayer.startPoint = CGPoint(x: 0.98, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.15, y: 1)
        
        let firstBG = UIColor(named: "CardBGGradientTo")!.cgColor
        let secondBG = UIColor(named: "CardBGGradientFrom")!.cgColor
        
        gradientLayer.colors = [firstBG, secondBG]
        gradientLayer.cornerRadius = radius
        
        addView.layer.cornerRadius = radius
        addView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    fileprivate func addButton(button: UIButton, withColors colors: [CGColor], radius: CGFloat) {
        
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame.size = button.frame.size
        
        // Start and end for left to right gradient
        gradientLayer.startPoint = CGPoint(x: 0.98, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.15, y: 1)
        
        let firstBG = colors[0]
        let secondBG = colors[1]
        
        gradientLayer.colors = [firstBG, secondBG]
        gradientLayer.cornerRadius = radius
        
        button.layer.cornerRadius = radius
        button.layer.insertSublayer(gradientLayer, at: 0)
        
    }

    fileprivate func setupTextFields() {
        
        // First
        textFieldName.layer.cornerRadius = tfRadius
        textFieldName.clipsToBounds = true
        textFieldName.attributedPlaceholder = NSAttributedString(string: "Название продукта...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldPlaceholderColor")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)])
        
        //Second
        textFieldAmount.layer.cornerRadius = tfRadius
        textFieldAmount.clipsToBounds = true
        textFieldAmount.attributedPlaceholder = NSAttributedString(string: "Количество...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldPlaceholderColor")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)])
    }
    
    
}
