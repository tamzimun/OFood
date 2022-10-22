//
//  MenuViewController.swift
//  OFood
//
//  Created by Aida on 18.10.2022.
//

import UIKit

enum Constants {
    static let bannerAndCategoryCollectionViewHeight: CGFloat = 260.0
}

protocol MenuViewInput: AnyObject {
    func handleObtainedBanners(_ banners: [BannerEntity])
    func handleObtainedFoodCategories(_ categories: [FoodCategoryEntity])
    func handleObtainedFoods(_ foods: [FoodEntity])
    func handleObtainedFilteredFoods(_ foodsId: Int)
}

protocol MenuViewOutput {
    func didLoadView()
    func didSelectCategoryCell(with category: String)
}


class MenuViewController: UIViewController {

    var output: MenuViewOutput?
    var menuDataDisplayManager: MenuDataDisplayManager?
    var bannersDataDisplayManager: BannerDataDisplayManager?
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Москва"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.image = UIImage(named: "arrow.png")
        return image
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
    
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(BannersCollectionViewCell.self, forCellWithReuseIdentifier: "BannersCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
    
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MenuCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCategoryCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let menuTableView: UITableView = {
        let table = UITableView()
        table.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.layer.cornerRadius = 20
        table.isScrollEnabled = false
        table.bounces = false
        table.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableCollectionViews()
        makeConstraints()
        output?.didLoadView()
    }
    
    private func setUpTableCollectionViews() {
        categoriesCollectionView.delegate = menuDataDisplayManager
        categoriesCollectionView.dataSource = menuDataDisplayManager
        bannersCollectionView.delegate = bannersDataDisplayManager
        bannersCollectionView.dataSource = bannersDataDisplayManager
        menuTableView.delegate = menuDataDisplayManager
        menuTableView.dataSource = menuDataDisplayManager
        scrollView.delegate = self
        
        menuDataDisplayManager?.onCategoryDidSelect = { [ weak self] category in
            self?.output?.didSelectCategoryCell(with: category)
        }
    }

    private func makeConstraints() {
        view.backgroundColor = #colorLiteral(red: 0.9511644244, green: 0.9611129165, blue: 0.9738450646, alpha: 1)
        let guide = view.safeAreaLayoutGuide
        let tableViewHeight = guide.layoutFrame.size.height - Constants.bannerAndCategoryCollectionViewHeight
        
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
        }

        view.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.left.equalTo(cityLabel.snp.right).offset(8)
            make.centerY.equalTo(cityLabel.snp.centerY)
            make.height.equalTo(8)
            make.width.equalTo(14)
        }

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY).priority(.low)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).priority(.low)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerY.equalTo(scrollView.snp.centerY).priority(.low)
            make.height.equalTo(scrollView.snp.height).priority(.low)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(cityLabel.snp.bottom)
            make.left.right.bottom.equalTo(scrollView.contentLayoutGuide)
        }
        
        scrollView.addSubview(bannersCollectionView)
        bannersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentInset.top).offset(24)
            make.left.equalTo(scrollView.contentInset.left).offset(16)
            make.right.equalTo(scrollView.contentInset.right)
            make.height.equalTo(112)
            make.width.equalTo(300)
        }

        scrollView.addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bannersCollectionView.snp.bottom).offset(24)
            make.left.equalTo(bannersCollectionView.snp.left)
            make.right.equalTo(bannersCollectionView.snp.right)
            make.height.equalTo(32)
        }

        scrollView.addSubview(menuTableView)
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(24)
            make.right.equalTo(bannersCollectionView.snp.right)
            make.left.bottom.equalTo(scrollView.contentInset)
            make.height.equalTo(tableViewHeight)
        }
    }
}

extension MenuViewController: MenuViewInput {
    func handleObtainedBanners(_ banners: [BannerEntity]) {
        bannersDataDisplayManager?.banners = banners
        bannersCollectionView.reloadData()
    }
    
    func handleObtainedFoodCategories(_ categories: [FoodCategoryEntity]) {
        menuDataDisplayManager?.categories = categories
        categoriesCollectionView.reloadData()
        
        // select first item of collection view, when categories are loaded
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        categoriesCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    func handleObtainedFoods(_ foods: [FoodEntity]) {
        menuDataDisplayManager?.foods = foods
        menuTableView.reloadData()
    }
    
    func handleObtainedFilteredFoods(_ foodsId: Int) {
        let indexPath = NSIndexPath(row: foodsId - 1, section: 0)
        menuTableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
}

extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (scrollView.contentOffset.y < 20){
            menuTableView.isScrollEnabled = false
            menuTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }

        bannersCollectionView.transform = CGAffineTransform(translationX: 0, y: max(0, scrollView.contentOffset.y - bannersCollectionView.bounds.maxY - 30))
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            checkHasScrolledToBottom()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkHasScrolledToBottom()
    }

    func checkHasScrolledToBottom() {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            menuTableView.isScrollEnabled = true
            menuTableView.layer.maskedCorners = []
        }
    }
}
