//
//  FirebaseCollectionRef.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 29/12/2023.
//
import Foundation
import Firebase

// MARK: - Firestore Collection Reference

/// Enum representing collection references in Firestore.
enum FirebaseColletionRef: String {
    case User
}

/// Function to get a Firestore collection reference based on the provided enum case.
///
/// - Parameter collectionReference: The enum case representing the collection reference.
/// - Returns: A `CollectionReference` based on the provided enum case.
func FirestoreRefrence(_ collectionReference: FirebaseColletionRef) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}

