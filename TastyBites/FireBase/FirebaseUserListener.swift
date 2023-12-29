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

  //MARK: - Login

  func loginUser(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
      if error == nil && authResult!.user.isEmailVerified {
        completion(error, true)
        self.downloadUserFromFirestore(userID: authResult!.user.uid)
      } else {
        completion(error, false)
      }
    }
  }


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

  //MARK: - Download User Data From Firestore
  private func downloadUserFromFirestore(userID: String) {
    FirestoreRefrence(.User).document(userID).getDocument { document, error in
      guard let userDocument = document else {
        print("no data")
        return
      }
      let result = Result {
        try? userDocument.data(as: User.self)
      }

      switch result {

      case .success(let userObject):
        if let user = userObject {
          saveUserLocally(user)
        } else {
          print("Document does not exist")
        }
      case .failure(_):
        print(error!.localizedDescription)
      }

    }
  }
}
