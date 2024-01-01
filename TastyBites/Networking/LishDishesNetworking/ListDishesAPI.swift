//
//  ListDishesAPI.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import Foundation

class ListDishesAPI: BaseAPI<LishDishesNetworking> {

  static let shared = ListDishesAPI()

  func getDishes(categoryId: String, completion: @escaping (Result<BaseResponse<[Dish]>, Error>) -> Void ) {
      self.fetchData(target: .getDishes(categoryId), responseClass: BaseResponse<[Dish]>.self) { result in
          completion(result)
      }
  }
}

