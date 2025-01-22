//
//  SwiftDataBookDataSource.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/12/24.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class SwiftDataBookDataSource {
    private let container: ModelContainer
    private let context: ModelContext
    
    init() {
        self.container = try! ModelContainer(for: BookDataModel.self)
        self.context = container.mainContext
    }

    func getBooks() async throws -> [BookDataModel] {
        do {
            let descriptor = FetchDescriptor<BookDataModel>()
            let bookDataModels = try context.fetch(descriptor)
            
            if bookDataModels.isEmpty {
                let localBooks = getBooksFromLocal()
                localBooks.forEach {
                    do {
                        try addBook($0)
                    } catch {
                        
                    }
                }
                return localBooks
            } else {
                return bookDataModels
            }
           
        } catch {
            print("Error loading books: \(error)")
            return []
        }
    }
    
    func getBook(from id: UUID) async throws -> BookDataModel? {
        let descriptor = FetchDescriptor<BookDataModel>(
            predicate: #Predicate { $0.id == id }
        )
        
        return try context.fetch(descriptor).first
    }
    
    func getBooksFromLocal() -> [BookDataModel] {
        guard let url = Bundle.main.url(forResource: "list_story", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return [] }
        let decoder = JSONDecoder()
          
        if let decodedData = try? decoder.decode([DecodableBook].self, from: data) {
            return decodedData.map { BookDataModel(from: $0 )}
        }
        return []
    }
    
    func addBook(_ bookDataModel: BookDataModel) throws {
        context.insert(bookDataModel)
        try context.save()
    }
    
    func unloackBook(_ id: UUID) throws {
        let descriptor = FetchDescriptor<BookDataModel>(
            predicate: #Predicate { $0.id == id }
        )
        
        if let bookDataModel = try context.fetch(descriptor).first {
            if bookDataModel.locked {
                bookDataModel.locked = false
                
                try context.save()
            }
        }
    }
    
    func deleteBook(_ bookDataModel: BookDataModel) throws {
        let bookDataModelID = bookDataModel.id
        
        let descriptor = FetchDescriptor<BookDataModel>(
            predicate: #Predicate { $0.id == bookDataModelID }
        )
        
        // Fetch the first matching record with the specified id
        if let bookDataModel = try context.fetch(descriptor).first {
            // If a match is found, delete it from the context and save the changes
            context.delete(bookDataModel)
            try context.save()
        }
        // If no match is found, this function does nothing, ensuring safe handling.
    }
}
