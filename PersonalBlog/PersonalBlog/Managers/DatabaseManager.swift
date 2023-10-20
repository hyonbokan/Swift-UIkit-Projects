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
    
    
}
