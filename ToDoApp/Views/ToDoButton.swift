//
//  ToDoButton.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-25.
//

import SwiftUI

struct ToDoButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            // Action
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.purple)
                
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}
            

    struct  ToDoButton_Previews: PreviewProvider {
                   static var previews: some View {
                       ToDoButton(title: "Value") {
                           // Action
                       }
                   }
               }
   

