//
//  DatabaseManager.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import Foundation
import FirebaseFirestore

final class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database = Firestore.firestore()
    
    init() {}
    
    // Change it to save username instread of email
    public func createUser(
        user: User,
        completion: @escaping (Bool) -> Void
    ) {
//        let documentId = user.email
//            .replacingOccurrences(of: ".", with: "_")
//            .replacingOccurrences(of: "@", with: "_")
//        let data = [
//            "email": user.email,
//            "name": user.name
//        ]
//        database
//            .collection("users")
//            .document(documentId)
//            .setData(data) { error in
//                completion(error == nil)
//            }
        let reference = database.document("users/\(user.name)")
        guard let data = user.asDictionary() else {
            completion(false)
            return
        }
        // store data(username: example, email: exmaple) in the Firestore database document
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
    
    public func findUserWithName(
        username: String,
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
            
            let user = users.first(where: { $0.name == username })
            completion(user)
        }
    }
    
    public func findUserWithEmail(
        email: String,
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
    
    public func createPost(
        newPost: BlogPost,
        completion: @escaping (Bool) -> Void
    ) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            print("Could not find the user in UserDefaults")
            completion(false)
            return
        }
        
        let ref = database.document("users/\(username)/posts/\(newPost.id)")
        guard let data = newPost.asDictionary() else {
            completion(false)
            print("Could not encode the post data into dict")
            return
        }
        
        ref.setData(data) { error in
            completion(error == nil)
        }
    }
    
    public func getPosts(
        username: String,
        completion: @escaping (Result<[BlogPost], Error>) -> Void
    ) {
        let ref = database
            .collection("users")
            .document(username)
            .collection("posts")
        
        ref.getDocuments { snapshot, error in
            guard let posts = snapshot?.documents.compactMap({
                BlogPost(with: $0.data()
                )}).sorted(by: { return $0.date > $1.date
                }),
                  error == nil else {
                return
            }
            completion(.success(posts))
        }
    }
    
    public func findAllUsers(
        completion: @escaping ([String]) -> Void
    ) {
        let ref = database
            .collection("users")
        ref.getDocuments { snapshot, error in
            guard let allUsers = snapshot?.documents.compactMap({ $0.documentID }),
                  error == nil else {
                completion([])
                return
            }
            completion(allUsers)
        }
    }
}
