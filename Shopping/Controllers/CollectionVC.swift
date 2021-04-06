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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        addBackgroundGradient()
        setupNavigationBarDesign()
    }
    
    
    private func registerCells() {
        collectionView.register(UINib.init(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }
    
    private func addBackgroundGradient() {
        
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
    
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        print("Haha")
    }
    
    
}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
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
        
        //cell.layer.masksToBounds = true
        
        
        cell.prepareForReuse()

        cell.button.setImage(UIImage(named: "CheckMarkCV"), for: .normal)
        cell.textLabel.text = "A lot of fucking text just to make shure that nothing is working correctly"
        //cell.textLabel.text = "Hello"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(withIdentifier: "ShowTableView", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "ShowTableView" else { return }
//    }
}
