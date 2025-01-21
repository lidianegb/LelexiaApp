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
    var viewState: ViewState = .loading
    
    @ObservationIgnored
    private let bookUseCases: BookUseCases
    
    init(bookUseCases: BookUseCases) {
        self.bookUseCases = bookUseCases
    }

    func loadBooks() async {
        viewState = .loading
        do {
            books = try await bookUseCases.fetchBooks()
            viewState = .data
        } catch {
            print("Error loading books: \(error)")
            viewState = .error
        }
    }
}
