//
//  BaseAPI.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {

    // MARK: - Fetch Data

    /// Generic method for making network requests using Alamofire.
    ///
    /// - Parameters:
    ///   - target: The target representing the details of the network request.
    ///   - responseClass: The type of the expected response model.
    ///   - completion: A closure called when the request is complete with a `Result` containing either the success model or an error.
    func fetchData<M: Codable>(target: T, responseClass: M.Type, completion: @escaping (Result<M, Error>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)

        AF.request(target.baseURL + target.path,
                   method: method,
                   parameters: params.0,
                   encoding: params.1,
                   headers: headers)
            .validate(statusCode: 200..<300) // Ensure the status code is in the success range
            .responseJSON { response in
                switch response.result {
                case .success(let jsonResponse):
                    guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse) else {
                        completion(.failure(NetworkError.serializationFailed))
                        return
                    }

                    do {
                        let responseObj = try JSONDecoder().decode(M.self, from: theJSONData)
                        completion(.success(responseObj))
                    } catch {
                        completion(.failure(error))
                    }

                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    // MARK: - Build Parameters

    /// Builds parameters based on the task type.
    ///
    /// - Parameter task: The task type representing the parameters and encoding.
    /// - Returns: A tuple containing parameters and encoding.
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
          return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}

// MARK: - Network Error

/// Custom enum representing errors specific to network requests.
enum NetworkError: Error {
    case serializationFailed
}

