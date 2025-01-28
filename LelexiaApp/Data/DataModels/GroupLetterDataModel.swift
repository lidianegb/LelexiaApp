//
//  GroupLetterDataModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 28/01/25.
//

import Foundation
import SwiftData

@Model
class GroupLetterDataModel {
    @Attribute(.unique) var id: UUID
    var letters: [String]
    var count: Int
    @Relationship(deleteRule: .nullify, inverse: \AlphabetDataModel.groups) var alphabet: AlphabetDataModel?
    
    init(from data: DecodableGroupLetter) {
        self.id = UUID()
        self.letters = data.letters
        self.count = data.count
    }
    
    init(from data: GroupLetter) {
        self.id = data.id
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
