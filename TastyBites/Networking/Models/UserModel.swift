//
//  UserModel.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

struct User: Codable {
  var id = ""
  var name: String
  var email: String
  var personalIamge = ""
}

func saveUserLocally(_ user: User) {
  let encoder = JSONEncoder()
  do {
    let data = try encoder.encode(user)
    userDefaults.set(data, forKey: CurrentUser)
  } catch {
    print("error")
  }
}
