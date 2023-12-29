//
//  FirebaseCollectionRef.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 29/12/2023.
//

import Foundation
import Firebase

enum FirebaseColletionRef: String {
  case User
}

func FirestoreRefrence(_ collectionRefrence: FirebaseColletionRef) -> CollectionReference {
  return Firestore.firestore().collection(collectionRefrence.rawValue)
}
