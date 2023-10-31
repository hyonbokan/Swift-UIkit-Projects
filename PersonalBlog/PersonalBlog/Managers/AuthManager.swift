//
//  AuthManager.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    init() {}
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public func signIn(
        email: String,
        password: String,
        completion: @escaping (Bool) -> Void
    ) {
        
        DataBaseManager.shared.findUserWithEmail(email: email) { [weak self] user in
            guard let user = user else {
                completion(false)
                return
            }
            self?.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(false)
                    return
                }
                
                UserDefaults.standard.set(user.name, forKey: "username")
                UserDefaults.standard.set(user.email, forKey: "email")
                completion(true)
            }
        }
    }
    
    public func signUp(
        email: String,
        username: String,
        password: String,
        completion: @escaping (Bool) -> Void
    ) {
        let newUser = User(name: username, email: email)
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            // add to db
            DataBaseManager.shared.createUser(user: newUser) { success in
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    
    public func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            completion(true)
        } catch {
            print(error)
            completion(false)
        }
    }
}
