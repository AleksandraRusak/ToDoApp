//
//  ToDoListItemsView.swift
//  ToDoApp
//
//  Created by Aleksandra Rusak on 2023-10-24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    @State private var searchText = ""
    
    @State private var editingItem: ToDoListItem? // For editing existing items


    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredItems) { item in
                    ToDoListItemView(item: item, toggleIsDone: {
                                           viewModel.toggleIsDone(item: item)
                                       })
                                       .swipeActions {
                                           Button("Edit") {
                                               editingItem = item
                                               viewModel.showingNewItemView = true
                                           }
                                           .tint(.blue)
                                           
                                           Button("Delete") {
                                               viewModel.delete(id: item.id)
                                           }
                            .tint(.red)
                        }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("To Do List")
            .searchable(text: $searchText) // Using the searchable modifier
            .toolbar {
                Button {
                    editingItem = nil // Reset for adding new item
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.purple)
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView, content: {
                NewItemView(newItemPresented: $viewModel.showingNewItemView, itemToEdit: editingItem)
            })
        }
    }

    private var filteredItems: [ToDoListItem] {
        if searchText.isEmpty {
            return items.sorted(by: { $0.dueDate > $1.dueDate })
        } else {
            return items.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
                        .sorted(by: { $0.dueDate > $1.dueDate })
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "zP45s8Dl4sWBmJhXQG4eTaRfcki2")
    }
}
