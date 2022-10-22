//
//  MenuInteractor.swift
//  OFood
//
//  Created by Aida on 18.10.2022.
//

import Foundation

protocol MenuInteractorInput {
    func obtainFoods()
    func ontainFilteredFoods(with foods: [FoodEntity], category: String)
}

protocol MenuInteractorOutput: AnyObject {
    func didLoadFoods(_ foods: [FoodEntity])
    func didFilteredFoods(_ foodsId: Int)
}

final class MenuInteractor: MenuInteractorInput {
    weak var output: MenuInteractorOutput!
    private var network: Networkable
    
    required init(network: Networkable) {
        self.network = network
    }

    func obtainFoods() {
        network.fetchData(path: "/v3/14ca996d-e902-422a-bffb-08209df8dee4") { [weak self] (result : Result <[FoodEntity], APINetworkError>) in
            switch result {
            case .success(let foods):
                self?.output.didLoadFoods(foods)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func ontainFilteredFoods(with foods: [FoodEntity], category: String) {
        var foodId: Int = 0
        for item in foods {
            if item.category == category {
                foodId = item.id
                break
            }
        }
        output.didFilteredFoods(foodId)
    }
}
