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
        completion: @escaping (Bool) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid
//              let data = item.asDictionary()
        else {
            completion(false)
            return
        }
        let itemId = UUID().uuidString
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
    
}
