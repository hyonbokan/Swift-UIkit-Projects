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
    
    private let storage = Storage.storage()
    
    init() {}
    
    
}
