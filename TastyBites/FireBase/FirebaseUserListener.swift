//
//  FirebaseUserListner.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import Foundation
import Firebase


struct FirebaseUserListener {

  static let shared = FirebaseUserListener()

  //MARK: - Register User

  func registerNewUser(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      completion(error)
      if error == nil {
        authResult!.user.sendEmailVerification { error in
          completion(error)
        }
      }
      if authResult?.user != nil {
        let user = User(id: (authResult?.user.uid)!, name: email, email: email, personalIamge: "")
        saveUserToFirestore(user)
        saveUserLocally(user)
      }
    }
  }

  //MARK: - Save User To Firestore

  func saveUserToFirestore(_ user: User) {
    do {
      try FirestoreRefrence(.User).document(user.id).setData(from: user)
    } catch {
      print(error.localizedDescription)
    }
  }
}
