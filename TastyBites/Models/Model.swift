//
//  Model.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 06/01/2024.
//
import Foundation

// MARK: - Resault
struct Resaults: Codable {
    let data: AllDishes
}

// MARK: - DataClass
struct AllDishes: Codable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}

// MARK: - Dish Category
struct DishCategory: Codable {
    let id, name, image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}

// MARK: - Dish
struct Dish: Codable {
  let id: String?
  let name: String?
  let description: String?
  let image: String?
  let calories: Int?

  var formattedCalories: String {
    return "\(calories ?? 0) clories"
  }
}

// MARK: - Order
struct Order: Codable {
  let id: String?
  let name: String
  let dish: Dish?
}

