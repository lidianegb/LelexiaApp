//
//  Letter.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 28/01/25.
//

import Foundation

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

struct DecodableLetter: Codable {
    let value: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case value = "letra"
        case count = "contador"
    }
}
