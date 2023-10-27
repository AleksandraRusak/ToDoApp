//
//  ContentView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.


import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()


    var body: some View {
        
            SplashView()
            
//            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
//                // signed in
//                ToDoListView()
//            } else {
//                LoginView()
//            }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
