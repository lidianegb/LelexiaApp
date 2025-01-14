//
//  ParagraphUseCases.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation

@MainActor
struct ParagraphUseCases {
    private let repository: ParagraphRepository

    init(repository: ParagraphRepository) {
        self.repository = repository
    }

    func fetchParagraphs() async throws -> [Paragraph] {
        return try await repository.getParagraphs()
    }

    func addParagraphs(_ data: Paragraph) async throws {
        try await repository.addParagraph(data)
    }
}
