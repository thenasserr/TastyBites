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

  func myRequest() {
    request(route: .temp, method: .get, type: String.self) { _ in
      
    }
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

  private func request<T: Codable>(route: Route,
                                   method: Method,
                                   parameters: [String: Any]? = nil,
                                   type: T.Type,
                                   completion: @escaping (Result<T?, Error>) -> Void) {
    guard let request = createRequest(route: route, method: method, parameters: parameters) else {
      completion(.failure(AppError.unknownError))
      return
    }
    URLSession.shared.dataTask(with: request) { data, response, error in
      var result: Result<Data, Error>?
      if let data = data {
        result = .success(data)
        let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
        print("The response is: \(responseString)")
      }else if let error = error {
        result = .failure(error)
        print("The error is: \(error.localizedDescription)")
      }
      DispatchQueue.main.async {
        // TODO Hecode our result and send back to the user
      }
    }.resume()
  }
}
