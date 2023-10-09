//
//  AuthManager.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/08.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    let auth = Auth.auth()
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public func logIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        // trimmingCharacters - trim the space
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return
        }
        guard email.contains("@") && email.contains(".") else {
            return
        }
        
        return
    }
    
    public func register(
        name: String,
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard let userId = result?.user.uid else {
                return
            }
            // create "insertUser" in FirebaseManager
            let newUser = User(id: userId, name: name, email: email, joined: Date().timeIntervalSince1970)
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(userId)
                .setData(newUser.asDictionary())
            print("User registered")
        }
    }
}
