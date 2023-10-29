//
//  ToDoListViewViewModel.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import Foundation
import FirebaseFirestore

// list of all todos
class ToDoListViewViewModel: ObservableObject {
    
    @Published var showingNewItemView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
