//
//  SwiftDataWordDataSource.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class SwiftDataWordDataSource {
    private let container: ModelContainer
    private let context: ModelContext
    
    static let shared = SwiftDataWordDataSource()
 
    private init() {
        self.container = try! ModelContainer(for: WordDataModel.self)
        self.context = container.mainContext
    }

    func getWords() async throws -> [WordDataModel] {
        do {
            let descriptor = FetchDescriptor<WordDataModel>()
            let dataModels = try context.fetch(descriptor)
            return dataModels
        } catch {
            print("Error fetching paragraphs: \(error)")
            return []
        }
    }
    
    func getWord(from id: UUID) async throws -> WordDataModel? {
        let descriptor = FetchDescriptor<WordDataModel>(
            predicate: #Predicate { $0.id == id }
        )
        
        // Fetch the first matching record with the specified id
        let dataModel = try context.fetch(descriptor).first
        return dataModel
    }
    
    func addWord(_ dataModel: WordDataModel) async throws {
        context.insert(dataModel)
        try context.save()
    }
}
