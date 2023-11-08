//
//  ContentView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.


import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()

    @State var hideSplash = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if !hideSplash {
                    ZStack {
                        Color.purple.edgesIgnoringSafeArea(.all)
                        VStack {
                            Text("To Do")
                                .font(.system(size: 60))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Image("pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                    }
                } else {
                    
                if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
                    
                    TabView {
                        ToDoListView(userId: viewModel.currentUserId)
                            .tabItem{
                                Label("Home", systemImage: "house")
                            }
                        ProfileView()
                            .tabItem{
                                Label("Profile", systemImage: "person.circle")
                            }
                    }.accentColor(.purple)
                } else {
                    LoginView()
                }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    hideSplash = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
