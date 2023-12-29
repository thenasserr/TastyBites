//
//  BaseResponse.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//
import Foundation


class BaseResponse<T: Codable>: Codable {
    var status: String?
    var data: T?

    enum Codingkeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}
