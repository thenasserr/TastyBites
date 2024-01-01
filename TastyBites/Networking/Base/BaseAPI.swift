//
//  BaseAPI.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {

  func fetchData<M: Codable>(target: T, responseClass: M.Type, completion: @escaping (Result<M, Error>) -> Void) {
    let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
    let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
    let params = buildParams(task: target.task)
    AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { response in
      guard let statusCode = response.response?.statusCode else {
        // Add Error
        completion(.failure(NSError()))
        return
      }
      if statusCode == 200 {
        // Successed
        guard let jsonResponse = try? response.result.get() else {
          completion(.failure(NSError()))
          return
        }
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse) else {
          completion(.failure(NSError()))
          return
        }
        guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
          completion(.failure(NSError()))
          return
        }
        completion(.success(responseObj))

      } else {
        completion(.failure(NSError()))
      }

    }

  }


  private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
    switch task {

    case .requestPlain:
      return([:], URLEncoding.default)
    case .requestParameters(parameters: let parameters, encoding: let encoding):
      return(parameters, encoding)
    }
  }


  
  }

