//
//  WordRepositoryImpl.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation
import SwiftUI

class WordRepositoryImpl: WordRepository {
    
    @MainActor
    private let dataSource: SwiftDataWordDataSource

    init(dataSource: SwiftDataWordDataSource) {
        self.dataSource = dataSource
    }

    func getWords() async throws -> [Word] {
        let dataModels = try await dataSource.getWords()
        return dataModels.map { $0.mapToDomain() }
    }
    func getWord(from id: UUID) async throws -> Word? {
        let dataModel = try await dataSource.getWord(from: id)
        return dataModel?.mapToDomain()
    }
    
    func addWord(_ data: Word) async throws {
        try await dataSource.addWord(WordDataModel(from: data))
    }
}
