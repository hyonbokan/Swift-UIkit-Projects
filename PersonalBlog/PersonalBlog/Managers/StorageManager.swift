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
        let username = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        storage.child("\(username)/profile_picture.png").putData(data, metadata: nil) { _, error in completion(error == nil)
        }
    }
    
    public func getProfilePictureUrl(for email: String, completion: @escaping (URL?) -> Void) {
        let username = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        storage.child("\(username)/profile_picture.png").downloadURL { url, error in
            completion(url)
        }
    }
    
}
