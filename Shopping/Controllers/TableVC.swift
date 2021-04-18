//
//  TableVC.swift
//  Shopping
//
//  Created by pro2017 on 04/04/2021.
//

import UIKit

protocol TableVCDelegate {
    func changeCardDesignInCollection(_: Bool)
}

class TableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var list: List!
    
    //var delegate: TableVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(sender: tableView)
        setupNavigationController()
        addButtons()
        
        self.title = list.name
    }
    
    @objc func leftButtonAction(){
        self.navigationController!.popViewController(animated: true)
        //delegate?.changeCardDesignInCollection(true)
    }
    
    @objc func rightButtonAction() { 
        self.list.products.removeAll()
        self.tableView.reloadData()
    }
    
    @IBAction func getDataFromAddMenuSecond(segue: UIStoryboardSegue) {
        
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
}




// DELEGATE|DATASOURCE

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.products.isEmpty ? 0 : list.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.nameLabel.text = list.products[indexPath.row].name
        cell.amountLabel.text = list.products[indexPath.row].amount
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return cell
    }
    
}

// GET DATA

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
