//
//  AllDishes.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import Foundation

struct AllDishes: Decodable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}
