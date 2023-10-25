//
//  RegisterView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI

struct RegisterView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""

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
                    TextField("Full name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)
                    TextField("Email Address", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)

                    Button(action: {
                        // Create account
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.purple)

                            Text("Create account")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }

                Spacer()
            }
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
