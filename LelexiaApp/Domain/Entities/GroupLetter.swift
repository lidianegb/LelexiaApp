//
//  GroupLetter.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 28/01/25.
//

import Foundation

struct GroupLetter: Identifiable {
    let id: UUID
    let letters: [String]
    let count: Int
}

struct DecodableGroupLetter: Codable {
    let letters: [String]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case letters = "letras"
        case count = "contador"
    }
}
