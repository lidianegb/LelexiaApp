//
//  BookRepository.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 07/12/24.
//

import Foundation

protocol BookRepository {
    func getBooks() async throws -> [Book]
    func getBook(from id: UUID) async throws -> Book?
    func addBook(_ book: Book) async throws
    func unlockBook(_ id: UUID) async throws
    func deleteBook(_ book: Book) async throws
}
