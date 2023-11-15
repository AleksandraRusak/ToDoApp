//
//  ToDoListItem.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    // method to update a completion status
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
