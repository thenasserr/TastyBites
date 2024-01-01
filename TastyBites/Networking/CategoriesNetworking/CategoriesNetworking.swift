//
//  CategoriesNetworking.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import Foundation
import Alamofire

enum CategoriesNetworking {
    case getCategory
}

extension CategoriesNetworking: TargetType {
    var baseURL: String {
        switch self {

        default:
            return "https://yummie.glitch.me"
        }
    }

    var path: String {
        switch self {

        case .getCategory:
            return "/dish-categories"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getCategory:
            return .get
        }
    }

    var task: Task {
        switch self {

        case .getCategory:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return [:]
    }


}
