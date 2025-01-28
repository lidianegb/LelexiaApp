//
//  AlphabetUseCases.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import Foundation

@MainActor
struct AlphabetUseCases {
    private let repository: AlphabetRepository

    init(repository: AlphabetRepository) {
        self.repository = repository
    }

    func fetchAlphabet() async throws -> Alphabet? {
        return try await repository.getAlphabet()
    }
    
    func incrementLetter(_ value: String) async throws {
        return try await repository.incrementLetter(value)
    }
    
    func incrementGroup(_ id: UUID) async throws {
        return try await repository.incrementGroup(id)
    }
}
