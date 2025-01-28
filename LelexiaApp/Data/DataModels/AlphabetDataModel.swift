//
//  AlphabetDataModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import Foundation
import SwiftData

@Model
class AlphabetDataModel {
    @Attribute(.unique) var id: UUID
    var alphabet: [LetterDataModel]
    var groups: [GroupLetterDataModel]

    // Initialize from decodable
    init(from data: DecodableAlphabet) {
        self.id = UUID()
        self.alphabet = data.alphabet.map { LetterDataModel(from: $0)}
        self.groups = data.groups.map { GroupLetterDataModel(from: $0)}
    }
    
    // Map to the domain model
    func mapToDomain() -> Alphabet {
        return Alphabet(
            id: id,
            letters: alphabet.map { $0.mapToDomain() },
            groups: groups.map { $0.mapToDomain() }
        )
    }
}

@Model
class LetterDataModel {
    @Attribute(.unique) var id: UUID
    var letter: String
    var count: Int
    
    init(from data: DecodableLetter) {
        self.id = UUID()
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

@Model
class GroupLetterDataModel {
    @Attribute(.unique) var id: UUID
    var letters: [String]
    var count: Int
    
    init(from data: DecodableGroupLetter) {
        self.id = UUID()
        self.letters = data.letters
        self.count = data.count
    }
    
    // Map to the domain model
    func mapToDomain() -> GroupLetter {
        return GroupLetter(
            id: id,
            letters: letters,
            count: count
        )
    }
}
