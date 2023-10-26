//
//  StorageManager.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    init() {}
    
    public func uploadProfilePicture(
        email: String,
        data: Data?,
        completion: @escaping (Bool) -> Void
    ) {
        guard let data = data else {
            return
        }
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        storage.child("\(documentId)/profile_picture.png").putData(data, metadata: nil) { _, error in completion(error == nil)
        }
    }
    
    public func getProfilePictureUrl(for email: String, completion: @escaping (URL?) -> Void) {
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        storage.child("\(documentId)/profile_picture.png").downloadURL { url, error in
            completion(url)
        }
    }
    
    public func uploadPost(
        data: Data?,
        id: String,
        completion: @escaping (URL?) -> Void
    ) {
        guard let email = UserDefaults.standard.string(forKey: "email"), let data = data else {
            print("Storage: Could not get username from User Defaults")
            return
        }
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let ref = storage.child("\(documentId)/posts/\(id).png")
        ref.putData(data, metadata: nil) { _, error in
            ref.downloadURL { url, _ in
                completion(url)
            }
        }
    }
    
}
