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
    }
    
    @IBAction func tfAction(_ sender: UITextField) {
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupDesign() {
        
        textField.layer.cornerRadius = tfRadius
        textField.clipsToBounds = true
        
        viewGradient(withRadius: viewRadius)
        
        let firstCancel = UIColor(named: "RedColorTo")!.cgColor
        let secondCancel = UIColor(named: "RedColorFrom")!.cgColor
        buttonGradient(button: cancelButton, withColors: [firstCancel, secondCancel], radius: buttonRadius)
        
        let firstAdd = UIColor(named: "GreenColorTo")!.cgColor
        let secondAdd = UIColor(named: "GreenColorFrom")!.cgColor
        buttonGradient(button: addButton, withColors: [firstAdd, secondAdd], radius: buttonRadius)
        
    }
    
    fileprivate func viewGradient(withRadius radius: CGFloat) {
        
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
    
    fileprivate func buttonGradient(button: UIButton, withColors colors: [CGColor], radius: CGFloat) {
        
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
    

}
