//
//  BookDetailViewModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import Foundation
import SwiftUI

@Observable
@MainActor
class BookDetailViewModel {
    var book: Book?
    
    @ObservationIgnored
    private let bookUseCases: BookUseCases
    private let bookId: UUID
    
    init(bookUseCases: BookUseCases, bookID: UUID) {
        self.bookUseCases = bookUseCases
        self.bookId = bookID
    }

    func fetchData() async {
        do {
            book = try await bookUseCases.fetchBook(from: bookId)
        } catch {
            print("Error loading books: \(error)")
        }
    }
}
