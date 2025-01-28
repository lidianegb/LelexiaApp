//
//  PersistenceContainer.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 28/01/25.
//

import SwiftData

@MainActor
final class PersistenceContainer {
    static let shared = PersistenceContainer()

    let container: ModelContainer
    var mainContext: ModelContext {
        container.mainContext
    }

    private init() {
        do {
            self.container = try ModelContainer(for: AlphabetDataModel.self, BookDataModel.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
}
