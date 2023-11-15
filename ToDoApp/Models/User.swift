//
//  User.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
// properties id, name, email, and joined, can be converted to and from a JSON format due to Codable protocol.

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
