//
//  TableVC.swift
//  Shopping
//
//  Created by pro2017 on 04/04/2021.
//

import UIKit

//protocol TableVCDelegate {
//    func changeCardDesignInCollection(_: Bool)
//}

class TableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var list: List!
    
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(sender: tableView)
        setupNavigationController()
        addButtons()
        
        self.title = list.name

    }
    
    @objc func leftButtonAction(){
        self.navigationController!.popViewController(animated: true)
        performSegue(withIdentifier: "getDataFromTableVC", sender: self)
    }
    
    @objc func rightButtonAction() {
        self.list.products.removeAll()
        self.tableView.reloadData()
    }
    
    
    // DELETE ROWS | BUTTON DESIGN
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
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
        return list.products.isEmpty ? 0 : list.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        
        //cell.contentView.backgroundColor = UIColor.clear
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cell.nameLabel.text = list.products[indexPath.row].name
        cell.amountLabel.text = list.products[indexPath.row].amount
        
        // назначаем TableVC ответственным за выполнение кода ячейки
        cell.delegate = self
        cell.indexPath = indexPath
        cell.product = list.products[indexPath.row]

        self.isActiveButton(for: cell, isActive: list.products[indexPath.row].isSelected)
        
        return cell
    }
}

// GET DATA FROM ADD MENU TABLE

extension TableVC: AddMenuTVDelegate {
    
    func passData(item: Product) {
        list.products.insert(item, at: 0)
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
        
        let indexPathLast = IndexPath(row: list.products.count - 1, section: indexPath.section)
        
        if product.isSelected {
            
            list.products[indexPath.row] = product
            
            UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve) {
                self.tableView.moveRow(at: indexPath, to: indexPathLast)
            }
            
            list.products.remove(at: indexPath.row)
            self.list.products.append(product)
            
        } else {
            
            UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve) {
                self.tableView.moveRow(at: indexPath, to: [0,0])
            }
            
            list.products.remove(at: indexPath.row)
            self.list.products.insert(product, at: 0)

        }
        self.tableView.reloadData()
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    

}
