//
//  Model.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 06/01/2024.
//
import Foundation

// MARK: - Welcome
struct Resaults: Codable {
    let data: AllDishes
}

// MARK: - DataClass
struct AllDishees: Codable {
    let categories: [Category]
    let populars, specials: [Popular]
}

// MARK: - Category
struct Category: Codable {
    let id, title: String
    let image: String
}

// MARK: - Popular
struct Popular: Codable {
    let id, name, description: String
    let image: String
    let calories: Int
}
