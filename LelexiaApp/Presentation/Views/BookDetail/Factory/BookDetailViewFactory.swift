//
//  BookDetailViewFactory.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 13/12/24.
//

import Foundation

@MainActor
enum BookDetailViewFactory {
    static private let dataSource = SwiftDataBookDataSource()
    static private let repository = BookRepositoryImpl(dataSource: dataSource)
    static private let useCases = BookUseCases(repository: repository)
   
    static func create(id: UUID, nextBook: UUID? = nil) -> BookDetailView {
        let viewModel = BookDetailViewModel(bookUseCases: useCases, bookID: id, nextBookID: nextBook)
        return BookDetailView(viewModel: viewModel)
    }
}
