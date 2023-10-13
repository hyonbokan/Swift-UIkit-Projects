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
    
    enum AuthError: Error {
        case newUserCreation
        case signInFailed
    }
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public func logIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        DatabaseManager.shared.findUser(with: email) { [weak self] user in
            guard let user = user else {
                completion(.failure(AuthError.signInFailed))
                return
            }
            
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                }
                //By storing these values in UserDefaults, the app can easily access the username and email of the currently signed-in user without having to fetch them from the database every time.
                UserDefaults.standard.setValue(user.name, forKey: "username")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                UserDefaults.standard.setValue(user.id, forKey: "userId")
                UserDefaults.standard.setValue(user.joined, forKey: "joinedDate")
                completion(.success(user))
            })
        }
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
    
    public func logOut(completion: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            completion(true)
        } catch {
            print(error)
            completion(false)
        }
        
    }
}
