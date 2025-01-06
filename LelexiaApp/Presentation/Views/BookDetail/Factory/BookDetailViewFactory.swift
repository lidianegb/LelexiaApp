//
//  BookDetailViewFactory.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 13/12/24.
//

import Foundation

@MainActor
enum BookDetailViewFactory {
    static func create(id: UUID) -> BookDetailView {
        let viewModel = BookDetailViewModel()
        return BookDetailView(viewModel: viewModel)
    }
}
