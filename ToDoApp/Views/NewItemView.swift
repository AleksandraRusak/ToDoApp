//
//  NewItemView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI

struct NewItemView: View {
    
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented : Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("New Task")
                    .font(.system(size: 32))
                    .bold()
                    .padding(.top, 30)
                
                Form {
                    TextField("Title", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    DatePicker("Due Date", selection: $viewModel.dueDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    ToListButton(title: "Save") {
                        if viewModel.onSave {
                            viewModel.save()
                            newItemPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                    .padding()
                }
                .alert(isPresented: $viewModel.showAlert, content: {
                    Alert(title: Text("Error"), message: Text("Please fill in a title and select due date and time."))
                })
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
