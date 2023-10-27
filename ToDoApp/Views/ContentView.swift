//
//  ContentView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.


import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()

    var body: some View {
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
            }
            } else {
                LoginView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
