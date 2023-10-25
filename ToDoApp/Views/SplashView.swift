//
//  SplashView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-25.
//

import SwiftUI

struct SplashView: View {
    @Binding var showLogin: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(UIColor(hex: "#BC6FF8"))
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("To Do")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Image("pencil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)

                    NavigationLink("", destination: LoginView(), isActive: $showLogin)
                        .opacity(0)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showLogin = true
                }
            }
        }
    }
}

struct Splash_Previews: PreviewProvider {
    @State static var showLogin = false
    static var previews: some View {
        SplashView(showLogin: $showLogin)
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
