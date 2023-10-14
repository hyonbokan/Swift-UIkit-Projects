//
//  DatabaseManager.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/11.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    /// Find user for authentication
    /// - Parameters:
    ///   - email: registered email
    ///   - completion: returns user email
    public func findUser(
        with email: String,
        completion: @escaping (User?) -> Void
    ) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }),
                  error == nil
            else {
                completion(nil)
                return
            }
            
            let user = users.first(where: { $0.email == email })
            completion(user)
        }
    }
    
    public func saveItem(
        item: ToDoListItem,
        itemId: String,
        completion: @escaping (Bool) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid
        else {
            completion(false)
            return
        }
        // reference in db
        let ref = database
                    .collection("users")
                    .document(userId)
                    .collection("todos")
                    .document(itemId)
        ref.setData(item.asDictionary()) { error in
            completion(error == nil)
        }
    }
    
    public func findUserInfo(
        userId: String,
        completion: @escaping (User?) -> Void
    ) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data() )}) else {
                completion(nil)
                return
            }
            let user = users.first(where: { $0.id == userId})
            completion(user)
        }
    }
    
    public func findItem(
        userId: String,
        completion: @escaping (Result<[ToDoListItem], Error>) -> Void
    ) {
        let ref = database.collection("users").document(userId).collection("todos")
        
        ref.getDocuments { snapshot, error in
            guard let items = snapshot?.documents.compactMap({ ToDoListItem(with: $0.data())
            }) else {
                return
            }
            
            completion(.success(items))
        }
    }
    
    public func deleteItem(
        userId: String,
        itemId: String,
        completion: @escaping (Bool) -> Void
    ) {
        let ref = database
            .collection("users")
            .document(userId)
            .collection("todos")
            .document(itemId)
        ref.delete() { error in
            if let error = error {
                print("Error deleting the item in db: \(error.localizedDescription)")
                completion(false)
            }
            else {
                completion(true)
            }
        }
    }
    
}
