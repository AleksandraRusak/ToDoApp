//
//  RegisterViewViewModel.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import Foundation
import FirebaseAuth

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self?.inserUserRecord(id: userId)
        }
    }
    
    
    private func inserUserRecord(id: String) {
        
    }
    
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            //errorMessage = "Please fill in all fields"
            return false
        }
        // email @ and .com/.se
        guard email.contains("@") && email.contains(".") else {
            //errorMessage = "Please fill in all fields"
            return false
        }
        
        guard password.count >= 6 else {
            //errorMessage = "Password must be at least 6 characters long"
            return false
        }

        return true
    }
    
}
