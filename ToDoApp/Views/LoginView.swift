//
//  LoginView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""

    var body: some View {
        GeometryReader { geometry in
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
                    .padding(.top, -123)
                }
                .frame(width: geometry.size.width, height: 300)

                // Form
                Form {
                    TextField("Email Address", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)

                    Button(action: {
                        // Log in
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.purple)

                            Text("Log in")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }

                // Create Account
                VStack {
                    Text("New around here?")
                    Button("Create An Account") {
                        // Show registration
                    }
                }
                .padding(.bottom, 30)

                Spacer()
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
