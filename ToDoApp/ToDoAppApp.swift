//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI
import FirebaseCore

@main
struct ToDoAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
