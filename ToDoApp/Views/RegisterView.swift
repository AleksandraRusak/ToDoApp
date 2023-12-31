//
//  RegisterView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    
    var body: some View {
        GeometryReader { geometry in 
            VStack {
                // Header
                ZStack {
                    Image("register")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        Text("Register")
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                            .bold()

                        Text("Start planning")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                    }
                    .padding(.top, -140)
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 2.5)
                
                // Form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Full name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .padding(.top, 5)
                    TextField("Email address", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.top, 5)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)

                    ToListButton(title: "Create account"){
                        viewModel.register()
                    }
                        .padding(4)
                    }
                }
            .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }


struct Register_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
