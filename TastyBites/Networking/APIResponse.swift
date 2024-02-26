//
//  APIResponse.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
  let status: Int
  let message: String?
  let data: T?
  let error: String?
}

struct EmptyResponse: Codable {
}
