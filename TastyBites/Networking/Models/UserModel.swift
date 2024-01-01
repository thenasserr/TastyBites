//
//  UserModel.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestoreSwift

struct User: Codable {
  var id = ""
  var name: String
  var email: String
  var personalIamge = ""

  static var currentID: String {
    return Auth.auth().currentUser!.uid
  }

  static var currentUser: User? {
    if Auth.auth().currentUser != nil {
      if let data = userDefaults.data(forKey: CurrentUser) {
        let decoder = JSONDecoder()
        do {
          let userObject = try decoder.decode(User.self, from: data)
          return userObject
        } catch {
          print(error.localizedDescription)
        }
      }
    }
    return nil
  }
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
