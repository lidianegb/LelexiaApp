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
    case bookDetail(id: UUID)
    
    var id: Self { self }
}
