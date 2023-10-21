//
//  BlogPost.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import Foundation

struct BlogPost: Codable {
    let title: String
    let timestamp: TimeInterval
    let headerImageUrl: URL?
    let text: String
}
