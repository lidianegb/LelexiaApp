//
//  LetterDataModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 28/01/25.
//

import Foundation
import SwiftData

@Model
class LetterDataModel {
    @Attribute(.unique) var id: UUID
    var letter: String
    var count: Int
    @Relationship(deleteRule: .nullify, inverse: \AlphabetDataModel.alphabet) var alphabet: AlphabetDataModel?
    
    init(from data: DecodableLetter) {
        self.id = UUID()
        self.letter = data.value
        self.count = data.count
    }
    
    init(from data: Letter) {
        self.id = data.id
        self.letter = data.value
        self.count = data.count
    }
    
    // Map to the domain model
    func mapToDomain() -> Letter {
        return Letter(
            id: id,
            value: letter,
            count: count
        )
    }
}
