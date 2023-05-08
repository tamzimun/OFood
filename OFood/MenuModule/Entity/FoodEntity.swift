//
//  FoodEntity.swift
//  OFood
//
//  Created by tamzimun on 20.10.2022.
//

import Foundation

struct FoodEntity: Codable {
    var id: Int
    var category: String
    var image: String
    var foodName: String
    var description: String
    var price: String
}
