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

struct DecodableAlphabet: Codable {
    let alphabet: [DecodableLetter]
    let groups: [DecodableGroupLetter]
    
    enum CodingKeys: String, CodingKey {
        case alphabet = "alfabeto"
        case groups = "grupos"
    }
}
