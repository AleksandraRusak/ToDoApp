//
//  ContentView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.


import SwiftUI

struct ContentView: View {
    @State private var showLogin = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in // Add a GeometryReader
                ZStack {
                    Color(UIColor(hex: "#BC6FF8")) // Set the custom background color
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        Text("To Do")
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Image("pencil") // Replace "your_splash_image" with the actual image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150) // Adjust the size as needed

                        NavigationLink("", destination: LoginView(), isActive: $showLogin)
                            .opacity(0) // Hidden navigation link to navigate to the LoginView
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height) // Use the GeometryReader size
            }
            .onAppear {
                // Simulate a delay or add your logic here to navigate to the LoginView
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showLogin = true
                    }
                }
            }
        }
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
