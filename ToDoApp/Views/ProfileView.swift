//
//  ProfileView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if let user = viewModel.user {
                    // avatar
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .frame(width: 125, height: 125)
                        .padding()
                    
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
                
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
