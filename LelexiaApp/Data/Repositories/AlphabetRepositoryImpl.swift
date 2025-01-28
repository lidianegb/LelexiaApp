//
//  AlphabetRepositoryImpl.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import Foundation
import SwiftUI

class AlphabetRepositoryImpl: AlphabetRepository {
    @MainActor
    private let dataSource: SwiftDataAlphabetDataSource

    init(dataSource: SwiftDataAlphabetDataSource) {
        self.dataSource = dataSource
    }

    func getAlphabet() async throws -> Alphabet? {
        let alphabet = try await dataSource.getAlphabet()
        return alphabet.map { $0.mapToDomain() }
    }
    
    func incrementGroup(_ id: UUID) async throws {
        try await dataSource.incrementGroup(id)
    }
    
    func incrementLetter(_ value: String) async throws {
        try await dataSource.incrementLetter(value)
    }
}
