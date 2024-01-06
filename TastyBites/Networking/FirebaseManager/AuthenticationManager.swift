//
//  AuthenticationManager.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 02/01/2024.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

class AuthenticationManager {

  static let shared = AuthenticationManager()

  func registerUser(email: String, password: String) -> AnyPublisher<User, Error> {
    return Auth.auth().createUser(withEmail: email, password: password)
      .map(\.user)
      .eraseToAnyPublisher()
  }

  func loginUser(email: String, password: String) -> AnyPublisher<User, Error> {
    return Auth.auth().signIn(withEmail: email, password: password)
      .map(\.user)
      .eraseToAnyPublisher()
  }

}
