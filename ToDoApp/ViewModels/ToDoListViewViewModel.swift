//
//  ToDoListViewViewModel.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import Foundation

// list of all todos
class ToDoListViewViewModel: ObservableObject {
    
    @Published var showingNewItemView = false
    
    init() {}
}
