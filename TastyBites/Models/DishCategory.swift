//
//  DishCategory.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import Foundation

struct DishCategory: Decodable {
    let id, name, image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}
