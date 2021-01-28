//
//  CategoriesCell.swift
//  MarvelApp
//
//  Created by Amir on 1/27/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import UIKit

class CategoriesCell: UITableViewCell {
    
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    var customV:UIViewController?
    
    
    
    var items = [Results]() {
        didSet {
            DispatchQueue.main.async {
                self.categoryCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryCollectionView.collectionViewLayout.invalidateLayout()
        
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


//MARK:- Collection View
extension CategoriesCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.movieName.text = items[indexPath.row].name
        if let image = items[indexPath.row].thumbnail?.path , let ext = items[indexPath.row].thumbnail?._extension {
            if  let url = URL(string: image+"."+ext) {
                cell.movieImg.kf.setImage(with: url)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.layoutIfNeeded() // Patch: only to solve UIKit crash on Plus models
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
        vc.items = self.items
        customV?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.layoutIfNeeded() // Patch: only to solve UIKit crash on Plus models
        
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.size.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let collectionViewHeight = collectionView.frame.size.height - 20
        
        return CGSize(width: widthPerItem, height: collectionViewHeight)
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
}
