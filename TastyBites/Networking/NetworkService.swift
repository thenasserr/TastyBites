//
//  NetworkService.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import Foundation

struct NetworkService {

  static let shared = NetworkService()

  private init() {}

  func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void) {
      request(route: .fetchAllCategories, method: .get, completion: completion)
  }

  func placeOrder (dishId: String, name: String, completion: @escaping (Result<Order, Error>) -> Void) {
    let params = [
      "name": name
    ]
    request(route: .placeOrder(dishId), method: .post, parameters: params, completion: completion)
  }

  func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Dish], Error>) -> Void) {
      request(route: .fetchCategoryDishes(categoryId), method: .get, completion: completion)
  }

  func fetchOrders(completion: @escaping(Result<[Order], Error>) -> Void) {
      request(route: .fetchOrders, method: .get, completion: completion)
  }
  /// This function help us to generate a URLRequest
  /// - Parameters:
  ///   - route: the path
  ///   - method: type of request to be made
  ///   - parameters: whatever extra information you need to pass to the backend
  /// - Returns: URLRequest
   private func createRequest(route: Route,
                             method: Method,
                             parameters: [String: Any]? = nil) -> URLRequest? {

    let urlString = Route.baseUrl + route.description
    guard let url = urlString.asURL else { return nil }
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.httpMethod = method.rawValue
    if let params = parameters {
      switch method {

      case .get:
        var urlComponent = URLComponents(string: urlString)
        urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
        urlRequest.url = urlComponent?.url
      case .post, .delete, .patch:
        let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
          urlRequest.httpBody = bodyData
      }
    }
    return urlRequest
  }
  
  /// This function help us to Make a URLRequest
  /// - Parameters:
  ///   - route: the path
  ///   - method: type of request to be made
  ///   - parameters: whatever extra information you need to pass to the backend
  ///   - type: The Model
  private func request<T: Decodable>(route: Route,
                                   method: Method,
                                   parameters: [String: Any]? = nil,
                                   completion: @escaping (Result<T, Error>) -> Void) {
    guard let request = createRequest(route: route, method: method, parameters: parameters) else {
      completion(.failure(AppError.unknownError))
      return
    }
    URLSession.shared.dataTask(with: request) { data, response, error in
      var result: Result<Data, Error>?
      if let data = data {
        result = .success(data)
        let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
//        print("The response is: \(responseString)")
      }else if let error = error {
        result = .failure(error)
        print("The error is: \(error.localizedDescription)")
      }
      DispatchQueue.main.async {
        // TODO Hecode our result and send back to the user
        handleResponse(result: result, completion: completion)
      }
    }.resume()
  }
    
    func deleteOrder(orderId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let route = Route.deleteOrder(orderId)
        request(route: route, method: .delete) { (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


  private func handleResponse<T: Decodable> (result: Result<Data, Error>?, 
                                             completion: @escaping (Result<T, Error>) -> Void) {
    
    guard let result = result else {
      completion(.failure(AppError.unknownError))
      return
    }
    switch result {

    case .success(let data):
      let decoder = JSONDecoder()
      guard let response = try? decoder.decode(APIResponse<T>.self, from: data) else {
        completion(.failure(AppError.errorDecoding))
        return
      }
      if let error = response.error {
        completion(.failure(AppError.serverError(error)))
        return
      }
      if let decodedData = response.data {
        completion(.success(decodedData))
      } else {
        completion(.failure(AppError.unknownError))
      }
    case .failure(let error):
      completion(.failure(error))
    }
  }
}
