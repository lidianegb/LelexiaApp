//
//  BookListView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/12/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    
    @Bindable var viewModel: BookListViewModel
    @Environment(\.coordinator) var coordinator: NavigationCoordinator
    
    // State to manage showing the add book sheet
    @State private var isPresentingAddBookSheet = false
    
    var body: some View {
        List {
            ForEach(viewModel.books, id: \.id) { book in
                Text(book.title)
            }
            .onDelete(perform: deleteBookFromTheList)
            .onTapGesture {
                coordinator.navigate(to: .bookDetail(id: UUID()))
            }
        }
        .navigationTitle("Book List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    coordinator.presentSheet(.addBook)
                    isPresentingAddBookSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingAddBookSheet) {
            BookListViewFactory.createAddBook()
        }
        .task {
            await viewModel.loadBooks()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    coordinator.goBack()
                } label: {
                    Text("Voltar")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Separate function to handle deletion
    private func deleteBookFromTheList(at offsets: IndexSet) {
        offsets.forEach { index in
            let book = viewModel.books[index]
            Task {
                await viewModel.deleteBook(book)
            }
        }
    }
}

// Separate view for adding a new book
struct AddBookSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.coordinator) var coordinator: NavigationCoordinator
    @Bindable var viewModel: BookListViewModel
    
    // State properties to hold book details
    @State private var title = ""
    @State private var author = ""
    @State private var publishedDate = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                DatePicker("Published Date", selection: $publishedDate, displayedComponents: .date)
            }
            .navigationTitle("Add New Book")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            // Create a new book with user input
                            let newBook = Book(id: UUID(), title: title, author: author, publishedDate: publishedDate)
                            await viewModel.addBook(newBook)
                            dismiss() // Close the sheet
                            coordinator.dismissSheet()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss() // Close the sheet without saving
                        coordinator.dismissSheet()
                    }
                }
            }
        }
    }
}
