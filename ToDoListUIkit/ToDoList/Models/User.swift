//
//  User.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/08.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
