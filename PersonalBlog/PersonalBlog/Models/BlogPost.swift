//
//  BlogPost.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import Foundation

struct BlogPost: Codable {
    let id: String
    let title: String
    let postedDate: String
    let body: String
    let postUrlString: String
    let likers: [String]
    
    var date: Date {
        return DateFormatter.formatter.date(from: postedDate) ?? Date()
    }
    
    var storageReference: String? {
        guard let username = UserDefaults.standard.string(forKey: "username") else { return nil }
        return "\(username)/posts/\(id)"
    }
}
