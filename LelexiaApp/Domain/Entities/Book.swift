//
//  Book.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 07/12/24.
//

import Foundation

struct Book: Identifiable {
    let id: UUID
    var title: String
    var cover: String
    var locked: Bool
    var paragraphs: [Paragraph]
    var selectedWords: [Word]
}

struct DecodableBook: Codable {
    var title: String
    var cover: String
    var locked: Bool
    var paragraphs: [DecodableParagraph]
    var selectedWords: [DecodableWord]
    
    enum CodingKeys: String, CodingKey {
        case title = "titulo"
        case cover = "capa"
        case locked = "bloqueado"
        case paragraphs = "paragrafos"
        case selectedWords = "palavras"
    }
}
