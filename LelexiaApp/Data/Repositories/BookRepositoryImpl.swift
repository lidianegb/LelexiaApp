//
//  BookRepositoryImpl.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 06/12/24.
//

import Foundation
import SwiftUI

class BookRepositoryImpl: BookRepository {
    
    @MainActor
    private let dataSource: SwiftDataBookDataSource

    init(dataSource: SwiftDataBookDataSource) {
        self.dataSource = dataSource
    }

    func getBooks() async throws -> [Book] {
        let bookDataModels = try await dataSource.getBooks()
        return bookDataModels.map { $0.mapToDomain() }
    }

    func getBook(from id: UUID) async throws -> Book? {
        let bookDataModel = try await dataSource.getBook(from: id)
        return bookDataModel.map { $0.mapToDomain() }
    }
    func addBook(_ book: Book) async throws {
        try await dataSource.addBook(BookDataModel(from: book))
    }

    func deleteBook(_ book: Book) async throws {
        try await dataSource.deleteBook(BookDataModel(from: book))
    }
    
    func unlockBook(_ book: Book) async throws {
        try await dataSource.unloackBook(BookDataModel(from: book))
    }
}
