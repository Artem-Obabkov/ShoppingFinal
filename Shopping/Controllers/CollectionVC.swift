//
//  CollectionVC.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit


class CollectionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Работа с отображением ячеек CollectionView
    let itemsPerRow: CGFloat = 2.0
    let interItemSpacing: CGFloat = 22.0
    let edgeSpacing: CGFloat = 32.0
    var widthPerItem: CGFloat = 0.0
    // Логика ячеки
    var shouldUnhilight: Bool = true
    
    
    // Основной массив
    var mainList = [List]()
    
    var listItem: List?
    
    var indexPathToShare: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        addBackgroundGradient()
        setupNavigationBarDesign()
        setupGesturesOnCollection()
        
        // Переход на другое View
        setupTapGestureOnCollectionCell()
        
        collectionView.reloadData()
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        print("")
    }
    
    @IBAction func getDataFromAddMenu(segue: UIStoryboardSegue) {
        
        guard let addMenu = segue.source as? AddMenuCollection else { return }
        
        if addMenu.textField.text != "" && addMenu.textField.text != nil {
            let list = List(name: addMenu.textField.text!, isFavourite: false)
            mainList.insert(list, at: 0)
            collectionView.reloadData()
        }        
    }
    
    private func registerCells() {
        collectionView.register(UINib.init(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }
    
}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainList.isEmpty ? 0 : mainList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        //cell.backgroundColor = UIColor.green
        // Обрезаем углы
        addCellDesign(cell: cell, withColorName: "CollectionCard0", isPressed: false, indexPath: indexPath)
        
        //cell.prepareForReuse()

        cell.button.setImage(UIImage(named: "CheckMarkCV"), for: .normal)
        cell.textLabel.text = mainList[indexPath.row].name
        
        return cell
    }
    
// GESTURES LOGIC
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            
            self.addCellDesignWithAnimation(cell: cell, withColorName: "CollectionCard1", animationTime: 0.2, animationType: .curveEaseInOut, isPressed: true, indexPath: indexPath)
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            
            if shouldUnhilight {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
                    self.addCellDesignWithAnimation(cell: cell, withColorName: "CollectionCard0", animationTime: 0.1, animationType: .curveEaseOut, isPressed: false, indexPath: indexPath)
                }
            }
        }
    }

}


extension CollectionVC: UIGestureRecognizerDelegate {
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        // Если жест был отменен, то ячейка возвращается в свое нормальное положение
        if gestureRecognizer.state == .cancelled {
            self.shouldUnhilight = true
        }
        
        
        guard gestureRecognizer.state == .began else { return }
        self.shouldUnhilight = false
        
        let pozition = gestureRecognizer.location(in: collectionView)

        if let indexPath = collectionView?.indexPathForItem(at: pozition) {

            //guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionCell else { return }
            

            createAlert(with: "Дополнительная информация", message: nil, style: .actionSheet, indexPath: indexPath)

            print("Long press at item: \(indexPath.row)")


        }

        if gestureRecognizer.state == .ended, let indexPath = collectionView?.indexPathForItem(at: pozition) {

            
            
            print("Закончил выаолнение на ячейке \(indexPath.row)")

        }
    }
    
    
    // NAVIGATION
    
    @objc func handleTapWith(gestureRecognizer: UITapGestureRecognizer) {
        
        let pozition = gestureRecognizer.location(in: collectionView)
        
        if let indexPath = collectionView?.indexPathForItem(at: pozition) {
            
            let cell = collectionView.cellForItem(at: indexPath)!
            
            
            self.listItem = mainList[indexPath.row]
            self.indexPathToShare = indexPath
            performSegue(withIdentifier: "ShowTableView", sender: nil)
            
            // Позволяет применить дизайн к карточке с задержкой, после перехода на Table VC
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                self.addCellDesign(cell: cell, withColorName: "CollectionCard0", isPressed: false, indexPath: indexPath)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "ShowTableView", let tableVC = segue.destination as? TableVC else { return }
        
        tableVC.list = listItem
        tableVC.indexPath = indexPathToShare
        
    }
    
    // GET DATA FROM TABLEVC
    @IBAction func getDataFromTableVC(_ segue: UIStoryboardSegue) {
        guard let tableVC = segue.source as? TableVC else { return }
        
        if let indexPath = tableVC.indexPath {
            self.mainList[indexPath] = tableVC.list
        }
        
    }
    
}
