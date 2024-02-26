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

  // MARK: - Authentication

  /// Logs in a user with the provided email and password.
  ///
  /// - Parameters:
  ///   - email: The user's email.
  ///   - password: The user's password.
  ///   - completion: A closure to be executed when the login attempt is complete.
  ///                 It takes an optional error and a boolean indicating whether the email is verified.
  func loginUser(email: String, password: String, completion: @escaping (Error?, Bool) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
      if let error = error {
        // Handle authentication error
        completion(error, false)
      } else if let authResult = authResult, authResult.user.isEmailVerified {
        // If login is successful and email is verified
        completion(nil, true)
        downloadUserFromFirestore(userID: authResult.user.uid)
      } else {
        // If email is not verified
        completion(nil, false)
      }
    }
  }

  // MARK: - User Registration

  /// Registers a new user with Firebase Authentication, sends email verification, and stores user data.
  ///
  /// - Parameters:
  ///   - email: The email for the new user.
  ///   - password: The password for the new user.
  ///   - name: The name of the new user.
  ///   - completion: A closure that is called after the registration process is complete.
  ///                 It takes an optional error parameter indicating any errors during registration.
  func registerNewUser(email: String, password: String, name: String, completion: @escaping (Error?) -> Void) {
    // Create user account in Firebase Authentication
//    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//      // Call completion with the registration error (if any)
//      completion(error)
//
//      // Check if user creation was successful and there is no registration error
//      if error == nil {
//        // Send email verification
//        authResult!.user.sendEmailVerification { error in
//          completion(error)
//        }
//      }
//      if authResult?.user != nil {
//        let user = UserModel(id: (authResult?.user.uid)!, name: name, email: email, personalIamge: "")
//        // Save user data to Firestore
//        saveUserToFirestore(user)
//        // Save user data locally
//        saveUserLocally(user)
//      }
//    }
      
      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        completion(error)
        if error == nil {
          print("Success")
          authResult?.user.sendEmailVerification(completion: { error in
            completion(error)
          })
        }
        if authResult?.user != nil {
          let user = UserModel(id: (authResult?.user.uid)!, name: name, email: email, personalIamge: "")

          self.saveUserToFirebase(user)
          saveUserLocally(user)
        }
      }
  }



  // MARK: - User Logout

  /// Logs out the current user, removes user data, and calls the completion handler.
  ///
  /// - Parameter completion: A closure that is called after the logout process is complete.
  ///                         It takes an optional error parameter indicating any errors during logout.
  func logOutUser(completion: @escaping (Error?) -> Void) {
    do {
      // Sign out the user from Firebase Authentication
      try Auth.auth().signOut()

      // Remove user data from UserDefaults
      userDefaults.removeObject(forKey: CurrentUser)
      userDefaults.synchronize()

      // Call completion with no errors
      completion(nil)
    } catch let error as NSError {
      // Call completion with the logout error
      completion(error)
    }
  }


  // MARK: - Save User To Firestore

  /// Saves a user model to Firestore.
  ///
  /// - Parameter user: The user model to be saved.
    func saveUserToFirebase(_ user: UserModel) {
     do {
       try FirestoreRefrence(.User).document(user.id).setData(from: user)
     } catch {
       print(error.localizedDescription)
     }

   }

  // MARK: - Download User Data From Firestore

  /// Downloads user data from Firestore based on the provided user ID.
  ///
  /// - Parameter userID: The unique identifier of the user.
  private func downloadUserFromFirestore(userID: String) {
    // Get a reference to the "User" collection in Firestore
    let userRef = FirestoreRefrence(.User).document(userID)

    // Retrieve user document from Firestore
    userRef.getDocument { document, error in
      guard let userDocument = document else {
        // Handle the case where the document is not found
        print("No data found for userID: \(userID)")
        return
      }

      // Use Result type to handle errors during data parsing
      let result = Result {
        try? userDocument.data(as: UserModel.self)
      }

      switch result {
      case .success(let userObject):
        if let user = userObject {
          // Save user data locally
          saveUserLocally(user)
        } else {
          // Handle the case where UserModel couldn't be created
          print("Failed to create UserModel from Firestore data")
        }
      case .failure(let error):
        // Handle errors during data parsing
        print("Error parsing Firestore data: \(error.localizedDescription)")
      }
    }
  }


  // MARK: - Resend Verification Email

  /// Resends the email verification link to the currently signed-in user.
  ///
  /// - Parameters:
  ///   - email: The email of the currently signed-in user.
  ///   - completion: A closure that is called after the resend process is complete.
  ///                 It takes an optional error parameter indicating any errors during resend.
  func resendVerificationEmail(email: String, completion: @escaping (Error?) -> Void) {
    // Reload the current user to ensure up-to-date information
    Auth.auth().currentUser?.reload(completion: {  reloadError in
      if let reloadError = reloadError {
        // Handle the reload error
        completion(reloadError)
      } else {
        // Resend the email verification link
        self.sendEmailVerification(completion: completion)
      }
    })
  }

  /// Helper method to send the email verification link.
  ///
  /// - Parameter completion: A closure that is called after the resend process is complete.
  ///                         It takes an optional error parameter indicating any errors during resend.
  private func sendEmailVerification(completion: @escaping (Error?) -> Void) {
    Auth.auth().currentUser?.sendEmailVerification(completion: { sendError in
      // Call completion with the send email verification error (if any)
      completion(sendError)
    })
  }

  // MARK: - Reset Password

  /// Initiates the process of resetting a user's password by sending a reset email.
  ///
  /// - Parameters:
  ///   - email: The email address of the user requesting a password reset.
  ///   - completion: A closure that is called after the reset process is complete.
  ///                 It takes an optional error parameter indicating any errors during the reset.
  func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
    Auth.auth().sendPasswordReset(withEmail: email) { resetError in
      // Call completion with the reset password error (if any)
      completion(resetError)
    }
  }
}
