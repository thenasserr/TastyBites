//
//  Dish.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import Foundation

struct Dish {
  let id: String?
  let name: String?
  let description: String?
  let image: String?
  let calories: Int?

  var formattedCalories: String {
    return "\(calories ?? 0) clories"
  }
}
