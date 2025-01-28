//
//  ParagraphDataModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation
import SwiftData

@Model
class ParagraphDataModel {
    @Attribute(.unique) var id: UUID
    var paragraph: String
    var index: Int
    var image: String?
    @Relationship(deleteRule: .nullify, inverse: \BookDataModel.paragraphs) var book: BookDataModel?
    
    // Initialize from a domain model instance
    init(from data: Paragraph) {
        self.id = data.id
        self.index = data.index
        self.paragraph = data.paragraph
        self.image = data.image
    }
    
    // Initialize from decodable
    init(from data: DecodableParagraph) {
        self.id = UUID()
        self.index = data.index
        self.paragraph = data.paragraph
        self.image = data.image
    }
    
    // Map to the domain model
    
    func mapToDomain() -> Paragraph {
        Paragraph(id: id, index: index, paragraph: paragraph, image: image)
    }
}
