//
//  TableVC.swift
//  Shopping
//
//  Created by pro2017 on 04/04/2021.
//

import UIKit
import RealmSwift

//protocol TableVCDelegate {
//    func changeCardDesignInCollection(_: Bool)
//}

class TableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var editList: MainList!
    
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
    
    @objc func rightButtonAction() {
        try? realm.write {
            self.editList.products.removeAll()
        }
        self.tableView.reloadData()
    }
    
    
    // DELETE ROWS | BUTTON DESIGN
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteRowAction(at: indexPath)
    
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // TODO: Leading swipe action
        
//        guard let cell = tableView.cellForRow(at: indexPath) as? TableCell else { return nil}
//
//        let product = list.products[indexPath.row]
        
        let selectAction = selectProduct(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [selectAction])
    }
}




// DELEGATE|DATASOURCE

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    
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

// GET DATA FROM ADD MENU TABLE

extension TableVC: AddMenuTVDelegate {
    
    func passData(item: List<Product>) {
        
        try? realm.write {
            editList.products.insert(contentsOf: item, at: 0)
        }
        StorageManager.saveData(editList)
        
        self.tableView.reloadData()
    }
    
    // Нужен что бы обозначить TableVC делегатом AddMenuTable
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "AddViewTable", let addMenu = segue.destination as? AddMenuTable else { return }
        addMenu.delegate = self
    }
}

// CHECKMARK ON TABLE VIEW CELL

extension TableVC: TableCellDelegate {
    
    // логика при нажатии на checkmark каждой ячейки
    func productAction(cell: TableCell, product: Product, indexPath: IndexPath) {

        self.isActiveButton(for: cell, isActive: product.isSelected)
        
        let indexPathLast = IndexPath(row: editList.products.count - 1, section: indexPath.section)
        
        if product.isSelected {
            
            try? realm.write {
                editList.products[indexPath.row] = product
            }
            
            
            UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve) {
                self.tableView.moveRow(at: indexPath, to: indexPathLast)
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
