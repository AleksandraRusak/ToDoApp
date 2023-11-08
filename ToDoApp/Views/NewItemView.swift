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
    
    var itemToEdit: ToDoListItem? // Optional item for editing
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(itemToEdit == nil ? "New Task" : "Edit Task")
                    .font(.system(size: 32))
                    .bold()
                    .padding(.top, 30)
                    .foregroundColor(.purple)
                
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
                .onAppear {
                    // Prepopulate form if editing
                    if let item = itemToEdit {
                        viewModel.id = item.id // Existing item ID
                        viewModel.title = item.title
                        viewModel.dueDate = Date(timeIntervalSince1970: item.dueDate)
                    } else {
                        // Reset for new item
                        viewModel.reset()
                    }
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
        NewItemView(newItemPresented: .constant(true), itemToEdit: nil)
    }
}
