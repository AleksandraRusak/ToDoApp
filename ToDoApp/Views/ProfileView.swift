//
//  ProfileView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewViewModel()
    
    @State private var presentImagePicker = false
    @State private var presentActionScheet = false
    @State private var presentCamera = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    if let user = viewModel.user {
                        Group {
                                if let imageURL = viewModel.imageURL {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image.resizable()
                                                 .aspectRatio(contentMode: .fill)
                                                 .frame(width: 180, height: 180)
                                                 .clipShape(Circle())
                                        case .failure(_):
                                            Image(systemName: "person.circle.fill")
                                                 .resizable()
                                                 .aspectRatio(contentMode: .fill)
                                                 .frame(width: 180, height: 180)
                                                 .clipShape(Circle())
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                } else {
                                   Image(systemName: "person.circle")
                                    .resizable()
                                }
                            }
                                .foregroundColor(.purple)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 180, height: 180)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .padding()
                                .onTapGesture { self.presentActionScheet = true }
                                .sheet(isPresented: $presentImagePicker) {
                                    
                                    
                                    ImagePickerView(sourceType: presentCamera ? .camera : .photoLibrary, image: self.$viewModel.image, isPresented: self.$presentImagePicker, viewModel: viewModel)
                                    
                                    
                                }.actionSheet(isPresented: $presentActionScheet) { () -> ActionSheet in
                                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                        presentImagePicker = true
                                        presentCamera = true
                                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                        presentImagePicker = true
                                        presentCamera = false
                                    }), ActionSheet.Button.default(Text("Random Photo"), action: {
                                        viewModel.fetchImageWithCompletion()
                                    }),ActionSheet.Button.cancel()])
                                }
                            // users info: name, email, member since
                        Form {
                                Section(header: Text("Personal Information")) {
                                                Text("Name: \(user.name)")
                                                Text("Email: \(user.email)")
                                                Text("Member since: \(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                                                }

                                Section {
                                        Button("Log out", action: {
                                        viewModel.logOut()
                                    })
                                    .tint(.red)
                                    }
                            }
                          
                        } else {
                            Text("Loading Profile...")
                        }
                        
                    }.navigationTitle("Profile")
                
             }.onAppear {
                 viewModel.fetchUser()
             }.frame(width: geometry.size.width, height: geometry.size.height)
           }
        }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
