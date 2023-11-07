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
                                if let uiImage = viewModel.image {
                                   Image(uiImage: uiImage)
                                    .resizable()
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
                                    
                                    
                                    ImagePickerView(sourceType: presentCamera ? .camera : .photoLibrary, image: self.$viewModel.image, isPresented: self.$presentImagePicker)
                                    
                                    
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
                            // user info: name, email, member since
                            VStack(alignment: .leading) {
                                HStack{
                                    Text("Name: ")
                                        .bold()
                                    Text(user.name)
                                }.padding()
                                HStack{
                                    Text("Email: ")
                                        .bold()
                                    Text(user.email)
                                }.padding()
                                HStack{
                                    Text("Member since: ")
                                        .bold()
                                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                                }.padding()
                            }
                            // sign out
                            Button("Log out") {
                                viewModel.logOut()
                            }
                            .tint(.red)
                            .padding(.top, 80)
                            
                            Spacer()
                        } else {
                            Text("Loading Profile...")
                        }
                        
                    }.navigationTitle("Profile")
                
             }.onAppear {
                 //viewModel.fetchImageWithCompletion()
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



//    @State var image: Image? = Image(systemName: "person.circle")
