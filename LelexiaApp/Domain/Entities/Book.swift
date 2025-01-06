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
    var author: String
    var publishedDate: Date
}
