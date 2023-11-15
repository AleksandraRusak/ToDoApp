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
    @Published var imageURL: URL? = nil
    @Published var image: UIImage? {
        didSet {
            saveImageToFirebaseStorage(image)
        }
    }
    
    var loader = APIImage()
    
    func fetchUser() { //  Fetches the current user's data from Firestore based on their userID
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
                
                if let profileImageUrlString = data["profileImageUrl"] as? String,
                   let url = URL(string: profileImageUrlString) {
                    self?.imageURL = url
                }
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
    
    // upload an image to Firebase Storage
    func saveImageToFirebaseStorage(_ image: UIImage?) {
        guard let userId = Auth.auth().currentUser?.uid,
              let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        let storageRef = Storage.storage().reference().child("profile_images/\(userId).jpg")
        
        storageRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            guard let self = self, error == nil else {
                print("Error saving image to Firebase Storage: \(error?.localizedDescription ?? "")")
                return
            }
            // download URL of the image that was uploaded to Firebase Storage
            storageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "")")
                    return
                }
                // update the user's profile image URL
                self.updateUserProfileImageURL(downloadURL, for: userId)
            }
        }
    }
    
    // Updates the user's Firestore document with the new image URL and updates the imageURL property.
    func updateUserProfileImageURL(_ url: URL, for userId: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData(["profileImageUrl": url.absoluteString]) { error in
            if let error = error {
                print("Error updating user profile image URL: \(error.localizedDescription)")
                return
            }
            
            // Update the imageURL property to reflect the new URL
            DispatchQueue.main.async {
                self.imageURL = url
            }
        }
    }
}
