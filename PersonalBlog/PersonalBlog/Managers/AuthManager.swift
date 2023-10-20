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
