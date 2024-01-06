//
//  DatabaseManager.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 02/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import FirebaseFirestoreSwift
import Combine


//class DatabaseManager {
//
//  static let shared = DatabaseManager()
//
//  func FirestoreRefrence(_ collectionRefrence: FirebaseColletionRef) -> CollectionReference {
//    return Firestore.firestore().collection(collectionRefrence.rawValue)
//  }
//
//  func setCollectionUser(add user: UserModel) -> AnyPublisher<Bool, Error> {
//
//    FirestoreRefrence(.User).document(user.id).setData(from: user)
//  }
//}
