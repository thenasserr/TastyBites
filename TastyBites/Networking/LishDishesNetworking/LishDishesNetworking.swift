//
//  LishDishesNetworking.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import Foundation
import Alamofire

enum LishDishesNetworking {
    case getDishes(String)
}

extension LishDishesNetworking: TargetType {
    var baseURL: String {
        switch self {

        default:
            return "https://yummie.glitch.me"
        }
    }

    var path: String {
        switch self {

        case .getDishes(let categoryId):
            return "/dishes/\(categoryId)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getDishes:
            return .get
        }
    }

    var task: Task {
        switch self {

        case .getDishes:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return [:]
    }


}
