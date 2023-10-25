//
//  ContentView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.


import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()
    @State private var showLogin = false

    var body: some View {
        
        NavigationView {
            SplashView(showLogin: $showLogin)
            
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
                // signed in
                ToDoListView()
            } else {
                LoginView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
