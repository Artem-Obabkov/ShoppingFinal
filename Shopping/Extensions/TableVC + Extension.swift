//
//  TableVC + Extension.swift
//  Shopping
//
//  Created by pro2017 on 10/04/2021.
//

import UIKit

extension TableVC {
    
    // DESIGN
    
    func setupTableView(sender: UITableView) {
        
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
        
        // Separator
        tableView.separatorColor = UIColor(named: "SeparatorColor")
        tableView.tableFooterView = UIView()
        
    }
    
    func setupNavigationController() {
        
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
    
    func addButtons(){
        
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
    
    func deleteRowAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.list.products.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        action.backgroundColor = UIColor(named: "RedColorFrom")
        return action
    }
}
