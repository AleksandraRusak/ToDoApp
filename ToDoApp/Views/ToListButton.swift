//
//  ToDoButton.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-25.
//

import SwiftUI

struct ToListButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Button {
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
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
            

    struct  ToListButton_Previews: PreviewProvider {
                   static var previews: some View {
                       ToListButton(title: "Value") {
                       }
                   }
               }
   

