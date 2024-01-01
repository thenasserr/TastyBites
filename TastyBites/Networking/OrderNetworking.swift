//
//  OrderNetworking.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import Foundation
import Alamofire

enum OrderNetworking {
    case placeOrder(String)
  case fetchOrders
}

extension OrderNetworking: TargetType {
    var baseURL: String {
        switch self {

        default:
            return "https://yummie.glitch.me"
        }
    }

    var path: String {
        switch self {

        case .placeOrder(let dishId):
          return "/orders/\(dishId)"

        case .fetchOrders:
          return "/orders"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .placeOrder:
            return .post
        case .fetchOrders:
          return .get
        }
    }

    var task: Task {
        switch self {

        case .fetchOrders:
            return .requestPlain

        case .placeOrder(let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return [:]
    }


}

