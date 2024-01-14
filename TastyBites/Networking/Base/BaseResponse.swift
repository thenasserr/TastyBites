//
//  BaseResponse.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//
import Foundation

// MARK: - Base Response

/// A generic struct representing the base structure of API responses.
///
/// - Parameters:
///   - T: The type of the `data` field.
struct BaseResponse<T: Codable>: Codable {
    var status: Int?
    let message: String?
    var data: T?

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
    }
}

