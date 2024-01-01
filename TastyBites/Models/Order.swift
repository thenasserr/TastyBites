//
//  Order.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import Foundation

struct Order: Codable {
  let id: String?
  let name: String
  let dish: Dish?
}
