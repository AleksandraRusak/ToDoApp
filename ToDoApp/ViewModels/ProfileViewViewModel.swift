//
//  ProfileViewViewModel.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI
import FirebaseStorage

class ProfileViewViewModel: ObservableObject {
    
    @Published var user: User? = nil
    
    @Published var image: UIImage? = nil
    
    var loader = APIImage()
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        }catch {
            print(error)
        }
    }
    
    // Fetch a random image from an API
    func fetchImageWithCompletion() {
        loader.getImageWithCompletion { [weak self] image, error in
            self?.image = image
            self?.saveImageToFirebaseStorage(image)
        }
    }
    
    func saveImageToFirebaseStorage(_ image: UIImage?) {
            guard let userId = Auth.auth().currentUser?.uid,
                  let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
            let storageRef = Storage.storage().reference().child("profile_images/\(userId).jpg")
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error saving image to Firebase Storage: \(error)")
                    return
                }
                print("Image successfully saved to Firebase Storage.")
            }
        }
}
