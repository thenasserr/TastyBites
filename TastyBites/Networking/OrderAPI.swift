//
//  OrderAPI.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import Foundation

class OrderAPI: BaseAPI<OrderNetworking> {

  // MARK: - Shared Instance

  static let shared = OrderAPI()
  
  // MARK: - Place Order

  func placeOrder (dishId: String, name: String, completion: @escaping (Result<BaseResponse<Order>, Error>) -> Void) {
    self.fetchData(target: .placeOrder(dishId) , responseClass: BaseResponse<Order>.self) { result in
      completion(result)
    }
  }

  // MARK: - Fetch Orders
  
  func fetchOrders(completion: @escaping(Result<BaseResponse<[Order]>, Error>) -> Void) {
    self.fetchData(target: .fetchOrders, responseClass: BaseResponse<[Order]>.self) { result in
      completion(result)
    }
  }

  
}
