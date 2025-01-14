//
//  ParagraphRepositoryImpl.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation
import SwiftUI

class ParagraphRepositoryImpl: ParagraphRepository {
    
    @MainActor
    private let dataSource: SwiftDataParagraphDataSource

    init(dataSource: SwiftDataParagraphDataSource) {
        self.dataSource = dataSource
    }

    func getParagraphs() async throws -> [Paragraph] {
        let dataModels = try await dataSource.getParagrapths()
        return dataModels.map { $0.mapToDomain() }
    }
    func addParagraph(_ data: Paragraph) async throws {
        try await dataSource.addParagraph(ParagraphDataModel(from: data))
    }
}
