//
//  MenuPresenter.swift
//  OFood
//
//  Created by Aida on 18.10.2022.
//

import Foundation

final class MenuPresenter: MenuViewOutput, MenuInteractorOutput {
    
    weak var view: MenuViewInput!
    var interactor: MenuInteractorInput!
    var router: MenuRouterInput!
    
    private var banners: [BannerEntity] = [
        BannerEntity.init(bannerImage: "banner1.png"),
        BannerEntity.init(bannerImage: "banner2.png")
    ]
    
    private var categories: [FoodCategoryEntity] = [
        FoodCategoryEntity.init(category: "Пицца"),
        FoodCategoryEntity.init(category: "Комбо"),
        FoodCategoryEntity.init(category: "Десерты"),
        FoodCategoryEntity.init(category: "Напитки")
    ]
    
    private var foods: [FoodEntity] = []
    
    func didLoadView() {
        interactor.obtainFoods()
        view.handleObtainedBanners(banners)
        view.handleObtainedFoodCategories(categories)
        view.handleObtainedFoods(foods)
    }
    
    func didSelectCategoryCell(with category: String) {
        interactor.ontainFilteredFoods(with: foods, category: category)
    }
    
    func didLoadFoods(_ foods: [FoodEntity]) {
        self.foods = foods
        view.handleObtainedFoods(foods)
    }
    
    func didFilteredFoods(_ foodsId: Int) {
        view.handleObtainedFilteredFoods(foodsId)
    }

}
