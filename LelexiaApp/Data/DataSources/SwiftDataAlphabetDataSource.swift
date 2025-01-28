//
//  SwiftDataAlphabetDataSource.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class SwiftDataAlphabetDataSource {
    private let container: ModelContainer
    private let context: ModelContext
    
    init() {
        self.container = try! ModelContainer(for: AlphabetDataModel.self)
        self.context = container.mainContext
    }

    func getAlphabet() async throws -> AlphabetDataModel? {
        do {
            let descriptor = FetchDescriptor<AlphabetDataModel>()
            let dataModels = try context.fetch(descriptor)
            
            if dataModels.isEmpty {
                let localData = getAlphabetFromLocal()
                do {
                    try saveAlphabet(localData)
                } catch {
                    print("Error saving alphabet: \(error)")
                }
                return localData
            } else {
                return dataModels.first
            }
           
        } catch {
            print("Error loading alphabet: \(error)")
            return getAlphabetFromLocal()
        }
    }
    
    func saveAlphabet(_ dataModel: AlphabetDataModel?) throws {
        guard let dataModel else { return }
        context.insert(dataModel)
        try context.save()
    }
    
    private func getAlphabetFromLocal() -> AlphabetDataModel? {
        if let decodableAlphabet = JSONLoader.load(DecodableAlphabet.self, fromFile: "alphabet") {
            return AlphabetDataModel(from: decodableAlphabet)
        }
        return nil
    }
    
    func incrementLetter(_ value: String) async throws {
        let descriptor = FetchDescriptor<LetterDataModel>(
            predicate: #Predicate { $0.letter == value }
        )
        
        if let dataModel = try context.fetch(descriptor).first {
            dataModel.count += 1
            try context.save()
        }
    }
    
    func incrementGroup(_ id: UUID) async throws {
        let descriptor = FetchDescriptor<GroupLetterDataModel>(
            predicate: #Predicate { $0.id == id }
        )
        
        if let dataModel = try context.fetch(descriptor).first {
            dataModel.count += 1
            try context.save()
        }
    }
}
