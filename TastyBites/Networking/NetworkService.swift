//
//  NetworkService.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import Foundation

struct NetworkService {
  
  /// This function help us to generate a URLRequest
  /// - Parameters:
  ///   - route: the path
  ///   - method: type of request to be made
  ///   - parameters: whatever extra information you need to pass to the backend
  /// - Returns: URLRequest
   func createRequest(route: Route, 
                             method: Method,
                             parameters: [String: Any]? = nil) -> URLRequest? {

    let urlString = Route.baseURL + route.description
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
}
