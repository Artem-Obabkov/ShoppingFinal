//
//  TableVC.swift
//  Shopping
//
//  Created by pro2017 on 04/04/2021.
//

import UIKit

class TableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView(sender: tableView)
        addButtons()
    }
    
    
    fileprivate func setupTableView(sender: UITableView) {
        
        
        // Gradien
        let firstBG = UIColor(named: "TableViewTo")!.cgColor
        let secondBG = UIColor(named: "CardBGGradientFrom")!.cgColor
        
        let gradientLayer = CAGradientLayer()
        
        let backgroundView = UIView(frame: tableView.bounds)
        
        gradientLayer.startPoint = CGPoint(x: 0.98, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.15, y: 1)
        
        gradientLayer.colors = [firstBG,secondBG]
        
        gradientLayer.frame = tableView.bounds
        
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundView
        
        // Selector
        tableView.separatorColor = UIColor(named: "SeparatorColor")
        
        // NavigationBar NavigationBarColor
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "NavigationBarColor")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "TextColorMain")!, .font: UIFont(name: "Apple SD Gothic Neo", size: 24)!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "TextColorMain")!, .font: UIFont(name: "Apple SD Gothic Neo", size: 34)!]
        
        navigationController?.navigationBar.tintColor = UIColor(named: "TextColorMain")!
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        
    }
    
    fileprivate func addButtons(){
        
        // LeftBarButtonItem
        let imageLeft = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        
        let leftBtn: UIBarButtonItem = UIBarButtonItem(image: imageLeft, style: .plain, target: self, action: #selector(leftButtonAction))
        
        leftBtn.tintColor = UIColor(named: "GreenColorFrom")
        
        self.navigationItem.leftBarButtonItem = leftBtn
        
        //RigntBarButtonItem
        let imageRight = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        
        let rightBtn: UIBarButtonItem = UIBarButtonItem(image: imageRight, style: .plain, target: self, action: #selector(rightButtonAction))
        
        rightBtn.tintColor = UIColor(named: "RedColorFrom")
        
        self.navigationItem.rightBarButtonItem = rightBtn
        
    }

    @objc func leftButtonAction(){
        self.navigationController!.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    @objc func rightButtonAction() {
    }
    
}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.nameLabel.text = "Продукт"
        cell.amountLabel.text = "x99"
        
        return cell
    }
    
    
}
