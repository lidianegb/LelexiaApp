//
//  WordDataModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation
import SwiftData

@Model
class WordDataModel {
    
    @Attribute(.unique) var id: UUID
    var word: String
    var syllables: [String]
    var image: String?
    @Relationship(deleteRule: .nullify, inverse: \BookDataModel.selectedWords) var book: BookDataModel?
    
    // Initialize from a domain model instance
    init(from data: Word) {
        self.id = data.id
        self.word = data.word
        self.syllables = data.syllables
        self.image = data.image
    }
    
    // Initialize from decodable
    init(from data: DecodableWord) {
        self.id = UUID()
        self.word = data.word
        self.syllables = data.syllables
        self.image = data.image
    }
    
    // Map to the domain model
    func mapToDomain() -> Word {
        Word(id: id, word: word, syllables: syllables, letters: word.map { $0 }, image: image)
    }
}
