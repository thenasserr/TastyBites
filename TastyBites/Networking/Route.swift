//
//  Route.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import Foundation

enum Route {
    static let baseUrl = "https://yummie.glitch.me"
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String)
    case fetchOrders
    case deleteOrder(String)
    
    var description: String {
        switch self {
            case .fetchAllCategories:
                return "/dish-categories"
            case .placeOrder(let dishId):
                return "/orders/\(dishId)"
            case .fetchCategoryDishes(let categoryId):
                return "/dishes/\(categoryId)"
            case .fetchOrders:
                return "/orders"
            case .deleteOrder(let orderId):
                return "/orders/\(orderId)"
        }
    }
}
