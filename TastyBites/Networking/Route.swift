//
//  Route.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import Foundation

enum Route {

  static let baseURL = "https://yummie.glitch.me"

  case temp

  var description: String {
    switch self {
    case .temp : return "/dishes/cat1"

    }
  }
}
