//
//  ImagePickerView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-11-06.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    var viewModel: ProfileViewViewModel
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
            ImagePickerViewCoordinator(image: $image, isPresented: $isPresented, viewModel: viewModel)
        }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    var viewModel: ProfileViewViewModel
    
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>, viewModel: ProfileViewViewModel) {
        _image = image
        _isPresented = isPresented
        self.viewModel = viewModel
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            self.image = uiImage
            viewModel.saveImageToFirebaseStorage(uiImage)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
