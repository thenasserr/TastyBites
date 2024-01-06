//
//  CategoriesAPI.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import Foundation



class CategoriesAPI: BaseAPI<CategoriesNetworking> {

  static let shared = CategoriesAPI()

  func getGategories(completion: @escaping (Result<BaseResponse<AllDishes>, Error>) -> Void ) {
      self.fetchData(target: .getCategory, responseClass: BaseResponse<AllDishes>.self) { result in
          completion(result)
      }
  }
}
