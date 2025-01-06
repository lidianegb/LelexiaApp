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
    
    static let shared = SwiftDataBookDataSource()
 
    private init() {
        self.container = try! ModelContainer(for: BookDataModel.self)
        self.context = container.mainContext
    }

    func getBooks() async throws -> [BookDataModel] {
        do {
            let descriptor = FetchDescriptor<BookDataModel>()
            let bookDataModels = try context.fetch(descriptor)
            return bookDataModels
        } catch {
            print("Error fetching books: \(error)")
            return []
        }
    }
    
    
    func addBook(_ bookDataModel: BookDataModel) async throws {
        context.insert(bookDataModel)
        try context.save()
    }
    
    func deleteBook(_ bookDataModel: BookDataModel) async throws {
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
