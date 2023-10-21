//
//  User.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import Foundation

struct User: Codable {
    let name: String
    let email: String
    let profilePictureUrl: URL?
}
