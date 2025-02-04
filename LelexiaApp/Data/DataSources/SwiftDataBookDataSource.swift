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
    private let context: ModelContext
    
    init() {
        self.context = PersistenceContainer.shared.mainContext
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
                        print("Error saving book: \($0.title)")
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
        if let decodableBooks = JSONLoader.load([DecodableBook].self, fromFile: "list_story") {
            return decodableBooks.map { BookDataModel(from: $0 )}
        }
        return []
    }
    
    func addBook(_ bookDataModel: BookDataModel) throws {
        context.insert(bookDataModel)
        try context.save()
    }
    
    func unlockBook(_ id: UUID) throws {
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
