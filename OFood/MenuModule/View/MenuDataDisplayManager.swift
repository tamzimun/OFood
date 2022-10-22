//
//  MenuDataDisplayManager.swift
//  OFood
//
//  Created by Aida on 18.10.2022.
//

import UIKit

final class MenuDataDisplayManager: NSObject {
    var categories: [FoodCategoryEntity] = []
    var foods: [FoodEntity] = []
    
    var onCategoryDidSelect: ((String) -> Void)?
}

extension MenuDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCategoryCollectionViewCell", for: indexPath) as! MenuCategoryCollectionViewCell
        cell.configure(with: categories[indexPath.row].category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCategoryDidSelect?(categories[indexPath.row].category)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 32)
    }
}

extension MenuDataDisplayManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.configure(with: foods[indexPath.row])
        return cell
    }
}

