//
//  ToDolistItemViewModel.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/12.
//

import Foundation

struct NewItem: Codable {
    var title: String
    var dueDate = Date()
    var isDone: Bool
}
