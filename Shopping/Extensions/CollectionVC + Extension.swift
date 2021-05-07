//
//  CollectionVC + Extension.swift
//  Shopping
//
//  Created by pro2017 on 03/04/2021.
//

import UIKit


extension CollectionVC: UICollectionViewDelegateFlowLayout {
    
    // WORK WITH CELL FRAME
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var colViewSize: CGFloat = 0
        
        if Int(collectionView.frame.width) % 2 == 0 {
            colViewSize = collectionView.frame.width
        } else {
            colViewSize = collectionView.frame.width - 1
        }
        
        let paddingWidth = (edgeSpacing * 2) + interItemSpacing
        let aviableWidth = colViewSize - paddingWidth
        let widthPerItem = aviableWidth / itemsPerRow
        self.widthPerItem = widthPerItem
        //
        return CGSize(width: widthPerItem, height: widthPerItem * 0.97222)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if mainList.count == 1 {
            var leftInset: CGFloat = 0
            let halfScreen: CGFloat = collectionView.frame.width / 2
            
            leftInset = -(halfScreen) + 22
            
            return UIEdgeInsets(top: 22, left: leftInset, bottom: 22, right: 0)
        }
        
        return UIEdgeInsets(top: 22, left: 32, bottom: 22, right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    
    // TAP GESTURES
    
    func setupGestureOnCollectionCell() {

        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))

        longPressedGesture.minimumPressDuration = 0.3
        longPressedGesture.delegate = self

        collectionView?.addGestureRecognizer(longPressedGesture)
    }
    
    func setupTapGestureOnCollectionCell() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapWith(gestureRecognizer:)))
        
        tapGesture.delegate = self
        tapGesture.numberOfTouchesRequired = 1
        
        collectionView?.addGestureRecognizer(tapGesture)
    }
    
    // DESIGN
    
    func addBackgroundGradient() {
        
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame.size = view.frame.size
        
        // Start and end for left to right gradient
        gradientLayer.startPoint = CGPoint(x: 0.98, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.15, y: 1)
        
        let firstBG = UIColor(named: "BGGradientTo")!.cgColor
        let secondBG = UIColor(named: "BGGradientFrom")!.cgColor
        
        gradientLayer.colors = [firstBG, secondBG]
                
        collectionView.backgroundView = collectionViewBackgroundView
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    
    func setupNavigationBarDesign() {
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 13.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        // Navigation bar design
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor(named: "TextColorMain")!]
    }
    
    // CELL DESIGN
    
    func addCellDesignWithAnimation(cell: UICollectionViewCell, withColorName colorName: String, animationTime: TimeInterval, animationType: UIView.AnimationOptions, isPressed: Bool, indexPath: IndexPath) {

        UIView.animate(withDuration: animationTime, delay: 0.0, options: animationType) { 
            self.addCellDesign(cell: cell, withColorName: colorName, isPressed: isPressed, indexPath: indexPath)
        }
    }
    
    func addCellDesign(cell: UICollectionViewCell, withColorName colorName: String, isPressed: Bool, indexPath: IndexPath) {
        
        guard let cell = cell as? CollectionCell else { return }
        
        var isEven: Bool = false
        let borderWidth: CGFloat = 1
        
        if indexPath.row % 2 == 0 {
            isEven = true
        }
        
        if isPressed {
            
            // Очищаем тени
            cell.layer.shadowColor = UIColor.clear.cgColor
            cell.layer.shadowOpacity = 0
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowRadius = 0
            
            // Присваиваем новый дизайн рамки
            if isEven {
                setBordersFor(cell: cell, borderWidth: borderWidth, colorName: "NavigationBarColor")
            } else {
                setBordersFor(cell: cell, borderWidth: borderWidth, colorName: "Border3")
            }
            
            cell.contentView.backgroundColor = UIColor(named: colorName)!
            cell.contentView.layer.cornerRadius = 20
            
            // Добавляем внутренние тени
            cell.contentView.addShadow(to: [.top, .left], radius: 11, opacity: 0.140, color: UIColor.black.cgColor, insets: (x: 4, y: 2))
            cell.contentView.addShadow(to: [.bottom, .right], radius: 3, opacity: 0.05, color: UIColor(named: "TextColorMain")!.cgColor, insets: (x: 0, y: 0))
            
        } else {
            
            // Убираем внутренние тени 
            cell.contentView.removeAllShadows()
            
            // Устанавливаем новый цвет рамок
            setBordersFor(cell: cell, borderWidth: borderWidth, colorName: "CollectionCard1")
            
            
            cell.contentView.backgroundColor = UIColor(named: colorName)!
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
        }
    }
    
    private func setBordersFor(cell: CollectionCell, borderWidth: CGFloat, colorName: String) {
        cell.contentView.frame = cell.contentView.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        cell.contentView.layer.borderColor = UIColor(named: "\(colorName)")!.cgColor
        cell.contentView.layer.borderWidth = borderWidth
    }
    
    func isActiveCollCellButton(for cell: CollectionCell, isActive: Bool) {
        
        
        
        if isActive {
            
            let color = UIColor(named: "GreenColorFrom")!
            let configuration = UIImage.SymbolConfiguration(pointSize: 27, weight: .regular, scale: .large)
            let image = UIImage(systemName: "star.circle.fill", withConfiguration: configuration)?.withTintColor(color, renderingMode: .alwaysOriginal)
            
            //cell.button.backgroundColor = UIColor(named: "TextWhite")!
            //cell.button.mask?.backgroundColor = UIColor(named: "TextWhite")!
            cell.button.setImage(image, for: .normal)
            
        } else {
            
            let color = UIColor(named: "TextFieldPlaceholderColor")!
            let configuration = UIImage.SymbolConfiguration(pointSize: 27, weight: .regular, scale: .large)
            let image = UIImage(systemName: "circle", withConfiguration: configuration)?.withTintColor(color, renderingMode: .alwaysOriginal)

            cell.button.setImage(image, for: .normal)
        }
    }
    
    // ALERT CONTROLLER
    
    func createAlert(with mainTitle: String, message: String?, style: UIAlertController.Style, indexPath: IndexPath) {
        
        let alertVC = UIAlertController(title: mainTitle, message: message, preferredStyle: style)
        alertVC.overrideUserInterfaceStyle = .dark
        
        
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? CollectionCell else { return }
        
        
        // ALERT ACTIONS
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .default) { [weak self] _ in
            self?.addCellDesignWithAnimation(cell: cell, withColorName: "CollectionCard0", animationTime: 0.10, animationType: .curveEaseInOut, isPressed: false, indexPath: indexPath)
            cell.contentView.removeAllShadows()
        }
        
        let deleteButton = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] action in

            self?.addCellDesignWithAnimation(cell: cell, withColorName: "CollectionCard0", animationTime: 0.10, animationType: .curveEaseInOut, isPressed: false, indexPath: indexPath)
            cell.contentView.removeAllShadows()
            
            self?.collectionView.performBatchUpdates {
                
                try? realm.write {
                    self?.mainList.remove(at: indexPath.row)
                    self?.collectionView.deleteItems(at: [indexPath])
                }
            }
        }
        
        let editButton = UIAlertAction(title: "Редактировать", style: .default) { [weak self] action in
            
            self?.addCellDesignWithAnimation(cell: cell, withColorName: "CollectionCard0", animationTime: 0.10, animationType: .curveEaseInOut, isPressed: false, indexPath: indexPath)
            cell.contentView.removeAllShadows()
            
            self?.indexPathToTableVC = indexPath
            self?.listItem = self?.mainList[indexPath.row]
            self?.performSegue(withIdentifier: "EditCollectionCell", sender: nil)
            
        }
        
        // ALERT DESIGN
        
        editButton.titleTextColor = UIColor(named: "TextColorMain")
        cancelButton.titleTextColor = UIColor(named: "TextColorMain")
        deleteButton.titleTextColor = UIColor(named: "RedColorFrom")
        
        alertVC.addAction(editButton)
        alertVC.addAction(cancelButton)
        alertVC.addAction(deleteButton)
        
        present(alertVC, animated: true, completion: nil)
        
    }
}
