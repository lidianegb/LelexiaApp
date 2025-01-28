//
//  Alphabet.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import Foundation

struct Alphabet: Identifiable {
    let id: UUID
    let letters: [Letter]
    let groups: [GroupLetter]
    
    func getLettersValue() -> [String] {
        return letters.map { $0.value }.sorted(by: { $0 < $1 })
    }
}

struct Letter: Identifiable, Hashable {
    let id: UUID
    let value: String
    let count: Int
    var isFlipped: Bool
    
    init(id: UUID, value: String, count: Int, isFlipped: Bool = false) {
        self.id = id
        self.value = value
        self.count = count
        self.isFlipped = isFlipped
    }
    
    func copy() -> Letter {
        Letter(id: UUID(), value: value, count: 0)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct GroupLetter: Identifiable {
    let id: UUID
    let letters: [String]
    let count: Int
}

struct DecodableAlphabet: Codable {
    let alphabet: [DecodableLetter]
    let groups: [DecodableGroupLetter]
    
    enum CodingKeys: String, CodingKey {
        case alphabet = "alfabeto"
        case groups = "grupos"
    }
}

struct DecodableLetter: Codable {
    let value: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case value = "letra"
        case count = "contador"
    }
}

struct DecodableGroupLetter: Codable {
    let letters: [String]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case letters = "letras"
        case count = "contador"
    }
}
