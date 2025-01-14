//
//  SwiftDataParagraphDataSource.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class SwiftDataParagraphDataSource {
    private let container: ModelContainer
    private let context: ModelContext
    
    static let shared = SwiftDataParagraphDataSource()
 
    private init() {
        self.container = try! ModelContainer(for: ParagraphDataModel.self)
        self.context = container.mainContext
    }

    func getParagrapths() async throws -> [ParagraphDataModel] {
        do {
            let descriptor = FetchDescriptor<ParagraphDataModel>()
            let dataModels = try context.fetch(descriptor)
            return dataModels
        } catch {
            print("Error fetching paragraphs: \(error)")
            return []
        }
    }
    
    func addParagraph(_ dataModel: ParagraphDataModel) async throws {
        context.insert(dataModel)
        try context.save()
    }
}
