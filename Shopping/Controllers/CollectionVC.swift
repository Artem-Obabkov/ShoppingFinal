//
//  CollectionVC.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit
import RealmSwift


class CollectionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Работа с отображением ячеек CollectionView
    let itemsPerRow: CGFloat = 2.0
    let interItemSpacing: CGFloat = 22.0
    let edgeSpacing: CGFloat = 32.0
    var widthPerItem: CGFloat = 0.0
    
    // Передача на tableView
    var indexPathToTableVC: IndexPath?
    
    // Логика ячеки
    var shouldUnhilight: Bool = true
    
    // Первоначальное создание базы данных
    var isActivatedAlready = UserDefaults.standard.bool(forKey: "isActivatedAlready")
    
    // Модели
    var topLevelModel: Results<TopLevelItem>!
    var mainList = List<MainList>()
    var listItem: MainList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        // Дизайн
        addBackgroundGradient()
        setupNavigationBarDesign()
        setupGestureOnCollectionCell()
        
        // Переход на TableVC
        setupTapGestureOnCollectionCell()
        
        
        topLevelModel = realm.objects(TopLevelItem.self)
        
        // При первом запуске приложения создаем объект типа TopLevel в котором имеется массив MainList
        if isActivatedAlready {
            guard let item = topLevelModel.first else { return }
            mainList = item.mainList
        } else {
            firstInit()
        }
    }
    
    // Сигвей на AddMenuCollection
    
    @IBAction func addButtonAction(_ sender: UIButton) {
    }
    
    // BASE INIT
    
    private func registerCells() {
        collectionView.register(UINib.init(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }
    
    func firstInit() {
        UserDefaults.standard.setValue(true, forKey: "isActivatedAlreadyFinal")
        
        let topItem = TopLevelItem()
        StorageManager.saveData(topItem)
        mainList = topItem.mainList
    }
    
    
    // NAVIGATION IN->OUT
    
    @objc func handleTapWith(gestureRecognizer: UITapGestureRecognizer) {
        
        let pozition = gestureRecognizer.location(in: collectionView)
        
        if let indexPath = collectionView?.indexPathForItem(at: pozition) {
            
            let cell = collectionView.cellForItem(at: indexPath)!
            
            self.listItem = mainList[indexPath.row]
            self.indexPathToTableVC = indexPath
            performSegue(withIdentifier: "ShowTableView", sender: nil)
            
            // Возвращает стандартный дизайн ячейки с задержкой
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                self.addCellDesign(cell: cell, withColorName: "CollectionCard0", isPressed: false, indexPath: indexPath)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTableView" {
            guard let tableVC = segue.destination as? TableVC else { return }
            
            tableVC.editList = self.listItem
            tableVC.indexPathToReceive = self.indexPathToTableVC
            
        } else if segue.identifier == "EditCollectionCell" {
            guard let addMenu = segue.destination as? AddMenuCollection else { return }
            
            addMenu.mainListEditing = listItem
            addMenu.indexPathToRecieveAddMenu = indexPathToTableVC
            addMenu.editingBegan = true
        }
    }
    
    // UNWIND SEGUES
    
    @IBAction func getDataFromAddMenu(segue: UIStoryboardSegue) {
        
        guard let addMenu = segue.source as? AddMenuCollection else { return }
        
        guard let mainListItem = addMenu.mainListToShare else { return }
        
        try? realm.write {
            mainList.append(mainListItem)
        }
        
        self.collectionView.reloadData()

    }
    
    @IBAction func getEditedDataFromAddMenu(_ segue: UIStoryboardSegue) {
        
        guard let addMenu = segue.source as? AddMenuCollection else { return }
        
        guard let indexPath = addMenu.indexPathToRecieveAddMenu, let editedItem = addMenu.mainListEditing else { return }
        
        try? realm.write {
            self.mainList[indexPath.row] = editedItem
        }
        
        self.collectionView.reloadData()
        
        addMenu.editingBegan = false
    }
}

// DELEGATE / DATASOURCE

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainList.isEmpty ? 0 : mainList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        // CELL DESIGN
        addCellDesign(cell: cell, withColorName: "CollectionCard0", isPressed: false, indexPath: indexPath)
        
        let card = mainList[indexPath.row]
        
        isActiveCollCellButton(for: cell, isActive: card.isFavourite)
        
        cell.delegate = self
        cell.card = card
        cell.indexPath = indexPath

        cell.textLabel.text = mainList[indexPath.row].name
        
        return cell
    }
}

// GESTURES LOGIC

extension CollectionVC: UIGestureRecognizerDelegate {

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
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        // Если жест был отменен, то ячейка возвращается в свое нормальное положение
        if gestureRecognizer.state == .cancelled {
            self.shouldUnhilight = true
        }
        
        
        guard gestureRecognizer.state == .began else { return }
        self.shouldUnhilight = false
        
        let pozition = gestureRecognizer.location(in: collectionView)

        if let indexPath = collectionView?.indexPathForItem(at: pozition) {

            createAlert(with: "Дополнительные действия", message: nil, style: .actionSheet, indexPath: indexPath)
        }
    }
}


// CHECKMARK ON CARD

extension CollectionVC: CollectionCellDelegate {
    
    func cardAction(cell: CollectionCell, card: MainList, indexPath: IndexPath) {
        
        self.isActiveCollCellButton(for: cell, isActive: card.isFavourite)
        
        let indexPathLast = IndexPath(item: mainList.count - 1, section: indexPath.section)
        let indexPathFirst = IndexPath(item: 0, section: indexPath.section)
         
        if card.isFavourite {

                self.collectionView.deleteItems(at: [indexPath])
                try? realm.write {
                    self.mainList.remove(at: indexPath.row)
                }
                
                try? realm.write {
                    self.mainList.insert(card, at: indexPathFirst.row)
                }
                self.collectionView.insertItems(at: [indexPathFirst])
            
        } else {
                
                self.collectionView.deleteItems(at: [indexPath])
                try? realm.write {
                    self.mainList.remove(at: indexPath.row)
                }
                
                try? realm.write {
                    self.mainList.append(card)
                }
                self.collectionView.insertItems(at: [indexPathLast])
            
        }
        self.collectionView.reloadData()
    }
}
