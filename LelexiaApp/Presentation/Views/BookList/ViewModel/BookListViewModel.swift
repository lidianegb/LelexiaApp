//
//  BookListViewModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/12/24.
//

import Foundation
import SwiftData

@Observable
@MainActor
class BookListViewModel {
    
    var books: [Book] = []
    
    @ObservationIgnored
    private let bookUseCases: BookUseCases
    
    init(bookUseCases: BookUseCases) {
        self.bookUseCases = bookUseCases
    }

    // Load all books
    func loadBooks() async {
        do {
            books = try await bookUseCases.fetchBooks()
        } catch {
            print("Error loading books: \(error)")
        }
    }

    // Add a new book and reload
    func addBook(_ book: Book) async {
        do {
            try await bookUseCases.addBook(book)
            await loadBooks()
        } catch {
            print("Error adding book: \(error)")
        }
    }

    // Delete a book and reload
    func deleteBook(_ book: Book) async {
        do {
            try await bookUseCases.deleteBook(book)
            await loadBooks()
        } catch {
            print("Error deleting book: \(error)")
        }
    }
}
