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
        GeometryReader { geometry in // Add a GeometryReader
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

                        Text("Begin life planning")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                    }
                    .padding(.top, -123)
                }
                .frame(width: geometry.size.width, height: 300) // Use geometry.size.width

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
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.top, 5)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)

                    ToDoButton(title: "Create account"){
                        // Registration
                        viewModel.register()
                    }
                        .padding()
                    }
                }
            }
        }
    }


struct Register_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
