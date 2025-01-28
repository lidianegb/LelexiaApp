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
    
    init(from data: Alphabet) {
        self.id = data.id
        self.alphabet = data.letters.map { LetterDataModel(from: $0)}
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
