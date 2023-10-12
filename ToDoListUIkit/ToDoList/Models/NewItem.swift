//
//  ToDolistItemViewModel.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/12.
//

import Foundation

struct NewItem: Codable {
    let title: String
    let dueDate: TimeInterval
    var isDone: Bool
}
