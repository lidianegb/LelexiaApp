//
//  BookDataModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/12/24.
//

import Foundation
import SwiftData

@Model
class BookDataModel {
    
    @Attribute(.unique) var id: UUID
    var title: String?
    var author: String?
    var publishedDate: Date

    // Initialize from a domain model instance
    init(from book: Book) {
        self.id = book.id
        self.title = book.title
        self.author = book.author
        self.publishedDate = book.publishedDate
    }

    // Map to the domain model
    func mapToDomain() -> Book {
        return Book(id: id, title: title ?? "", author: author ?? "", publishedDate: publishedDate)
    }
    
}
