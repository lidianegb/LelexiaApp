//
//  Paragraph.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation

struct Paragraph: Identifiable {
    let id: UUID
    let paragraph: String
    let image: String?
}

struct DecodableParagraph: Codable {
    let paragraph: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case paragraph = "texto"
        case image = "imagem"
    }
}
