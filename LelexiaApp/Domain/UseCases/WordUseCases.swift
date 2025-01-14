//
//  WordUseCases.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation

@MainActor
struct WordUseCases {
    private let repository: WordRepository

    init(repository: WordRepository) {
        self.repository = repository
    }

    func fetchWords() async throws -> [Word] {
        return try await repository.getWords()
    }
    
    func fetchWord(form id: UUID) async throws -> Word? {
        return try await repository.getWord(from: id)
    }
    
    func addWord(_ data: Word) async throws {
        try await repository.addWord(data)
    }
}
