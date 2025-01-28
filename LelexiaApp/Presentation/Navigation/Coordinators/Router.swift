//
//  Router.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import Foundation

enum Router: Identifiable, Hashable {
    case home
    case bookList
    case bookDetail(id: UUID, next: UUID?)
    case memoryGame
    case alphabetView(letters: [Letter])
    
    var id: Self { self }
}
