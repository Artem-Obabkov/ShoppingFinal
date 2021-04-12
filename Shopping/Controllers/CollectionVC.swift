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
    
    // Основной массив
    var mainList = [List]()
    
    var listItem: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        addBackgroundGradient()
        setupNavigationBarDesign()
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        print("")
    }
    
    @IBAction func getDataFromAddMenu(segue: UIStoryboardSegue) {
        
        guard let addMenu = segue.source as? AddMenuCollection else { return }
        
        if addMenu.textField.text != "" && addMenu.textField.text != nil {
            let list = List(name: addMenu.textField.text!, isFavourite: false)
            mainList.append(list)
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

        // Обрезаем углы
        cell.contentView.layer.cornerRadius = 20

        // Создаем тень
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.43
        cell.layer.shadowOffset = CGSize(width: -3.0, height: 3.0)
        cell.layer.shadowRadius = 13

        // Без этой строчки ничего не отобразится
        cell.layer.masksToBounds = false

        // Следующие шаги позволяют быстрее редактировать тени
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shouldRasterize  = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        cell.prepareForReuse()

        cell.button.setImage(UIImage(named: "CheckMarkCV"), for: .normal)
        cell.textLabel.text = mainList[indexPath.row].name
        
        return cell
    }
    
    // NAVIGATION
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        listItem = mainList[indexPath.row]
        
        performSegue(withIdentifier: "ShowTableView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "ShowTableView", let tableVC = segue.destination as? TableVC else { return }
        
        tableVC.list = listItem
        
    }
}
