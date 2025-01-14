//
//  Word.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation

struct Word: Identifiable {
    let id: UUID
    var word: String
    var syllables: [String]
    var letters: [Character]
    var image: String?
}

struct DecodableWord: Codable {
    var word: String
    var syllables: [String]
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case word = "palavra"
        case syllables = "silabas"
        case image = "imagem"
    }
}
