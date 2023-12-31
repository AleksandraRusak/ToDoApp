//
//  LoginView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        GeometryReader { geometry in
        NavigationStack{
                VStack {
                    // Header
                    ZStack {
                        Image("login")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            Text("To Do List")
                                .font(.system(size: 50))
                                .foregroundColor(Color.white)
                                .bold()
                            
                            Text("Get things done")
                                .font(.system(size: 30))
                                .foregroundColor(Color.white)
                        }
                        .padding(.top, -133)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 2.5)
                    
                    
                    // Form
                    Form {
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        TextField("Email address", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .padding(.top, 5)
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.top, 5)
                        
                        ToListButton(title: "Log in"){
                            viewModel.login()
                        }
                        .padding(4)
                    }
                    
                    
                    // Create Account
                    VStack {
                        Text("New around here?")
                        NavigationLink("Create an account", destination: RegisterView())
                    }
                    .padding(.bottom, 30)
                    
                    Spacer()
                }
            }
        .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
