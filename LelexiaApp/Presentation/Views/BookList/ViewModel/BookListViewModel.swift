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

    func loadBooks() async {
        do {
            books = try await bookUseCases.fetchBooks()
        } catch {
            print("Error loading books: \(error)")
        }
    }
}
