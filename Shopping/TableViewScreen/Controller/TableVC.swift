//
//  TableVC.swift
//  Shopping
//
//  Created by pro2017 on 04/04/2021.
//

import UIKit
import RealmSwift


class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var editList: MainList!
    
    var indexPathToReceive: IndexPath?
    
    
    // EDIT PRODUCT
    
    var productToShare: Product?
    var indexPathToShare: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(sender: tableView)
        setupNavigationController()
        addButtons()
        
        self.title = editList.name
    }
    
    @objc func leftButtonAction(){
        self.navigationController!.popViewController(animated: true)
    }
    
    // DELETE ITEMS
    
    @objc func rightButtonAction() {
        try? realm.write {
            self.editList.products.removeAll()
        }
        self.tableView.reloadData()
    }
    
    // MAIN TABLEVIEW DATASOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editList.products.isEmpty ? 0 : editList.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        
        //cell.contentView.backgroundColor = UIColor.clear
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cell.nameLabel.text = editList.products[indexPath.row].name
        cell.amountLabel.text = editList.products[indexPath.row].amount
        
        // назначаем TableVC ответственным за выполнение кода ячейки
        cell.delegate = self
        cell.indexPath = indexPath
        cell.product = editList.products[indexPath.row]

        self.isActiveButton(for: cell, isActive: editList.products[indexPath.row].isSelected)
        
        return cell
    }
}

// NAVIGATION | GET DATA FROM ADD MENU TABLE

extension TableVC: AddMenuTVDelegate {
    
    // Прием данных с AddMenu в реальном времени
    
    func passData(item: List<Product>) {
        
        try? realm.write {
            editList.products.insert(contentsOf: item, at: 0)
        }
        
        self.tableView.reloadData()
    }
    
    // Нужен что бы обозначить TableVC делегатом AddMenuTable
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddViewTable" {
            
            guard let addMenu = segue.destination as? AddMenuTable else { return }
            addMenu.delegate = self
            
        } else if segue.identifier == "EditProduct" {
            
            guard let addMenuToEdit = segue.destination as? AddMenuTable else { return }
            
            guard let product = productToShare else { return }
            
            addMenuToEdit.productToEdit = product
            addMenuToEdit.indexPathToRecieve = indexPathToShare
            addMenuToEdit.editingBegan = true
            
        }
    }
    
    // UNWING SEGUE
    
    @IBAction func getEditedDataFromAddMenu(_ segue: UIStoryboardSegue) {
        
        guard let addMenu = segue.source as? AddMenuTable else { return }
        
        guard let indexPath = addMenu.indexPathToRecieve, let editedProduct = addMenu.productToEdit else { return }
        
        try? realm.write {
            
            editList.products[indexPath.row] = editedProduct
        }
        
        self.tableView.reloadData()
        
        addMenu.editingBegan = false
    }
    
    // SIDE BUTTONS
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteRowAction(at: indexPath)
    
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = editProduct(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
}

// CHECKMARK ON TABLE VIEW CELL

extension TableVC: TableCellDelegate {
    
    // Логика при нажатии на checkmark каждой ячейки
    
    func productAction(cell: TableCell, product: Product, indexPath: IndexPath) {

        self.isActiveButton(for: cell, isActive: product.isSelected)
        
        let indexPathLast = IndexPath(row: editList.products.count - 1, section: indexPath.section)
        
        if product.isSelected {
            
            try? realm.write {
                editList.products[indexPath.row] = product
            }
            
            UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve) { [weak self] in
                self?.tableView.moveRow(at: indexPath, to: indexPathLast)
            }
            
            try? realm.write {
                editList.products.remove(at: indexPath.row)
                self.editList.products.append(product)
            }
            
        } else {
            
            UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve) {
                self.tableView.moveRow(at: indexPath, to: [0,0])
            }
            
            try? realm.write {
                editList.products.remove(at: indexPath.row)
                self.editList.products.insert(product, at: 0)
            }
            
        }
        self.tableView.reloadData()
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}
