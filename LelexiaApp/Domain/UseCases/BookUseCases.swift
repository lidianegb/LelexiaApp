//
//  BookUseCases.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/12/24.
//

import Foundation

@MainActor
struct BookUseCases {
    private let repository: BookRepository

    init(repository: BookRepository) {
        self.repository = repository
    }

    func fetchBooks() async throws -> [Book] {
        return try await repository.getBooks()
    }

    func addBook(_ book: Book) async throws {
        try await repository.addBook(book)
    }

    func deleteBook(_ book: Book) async throws {
        try await repository.deleteBook(book)
    }
}
