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

    func fetchBook(from id: UUID) async throws -> Book? {
        return try await repository.getBook(from: id)
    }
    
    func addBook(_ book: Book) async throws {
        try await repository.addBook(book)
    }
    
    func unlockBook(_ id: UUID) async throws {
        try await repository.unlockBook(id)
    }

    func deleteBook(_ book: Book) async throws {
        try await repository.deleteBook(book)
    }
}
