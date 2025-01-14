//
//  BookDataModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/12/24.
//

import Foundation
import SwiftData

@Model
class BookDataModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var cover: String
    var locked: Bool
    var paragraphs: [ParagraphDataModel]
    var selectedWords: [WordDataModel]

    // Initialize from a domain model instance
    init(from book: Book) {
        self.id = book.id
        self.title = book.title
        self.cover = book.cover
        self.locked = book.locked
        self.paragraphs = book.paragraphs.map { ParagraphDataModel(from: $0) }
        self.selectedWords = book.selectedWords.map { WordDataModel(from: $0) }
    }

    // Initialize from decodable
    init(from book: DecodableBook) {
        self.id = UUID()
        self.title = book.title
        self.cover = book.cover
        self.locked = book.locked
        self.paragraphs = book.paragraphs.map { ParagraphDataModel(from: $0) }
        self.selectedWords = book.selectedWords.map { WordDataModel(from: $0) }
    }
    
    // Map to the domain model
    func mapToDomain() -> Book {
        return Book(
            id: id,
            title: title,
            cover: cover,
            locked: locked,
            paragraphs: paragraphs.map { $0.mapToDomain()},
            selectedWords: selectedWords.map { $0.mapToDomain()}
        )
    }
    
}
