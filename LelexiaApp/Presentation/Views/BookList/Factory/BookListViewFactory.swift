//
//  BookListViewFactory.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 13/12/24.
//

import Foundation

@MainActor
enum BookListViewFactory {
    static private let dataSource = SwiftDataBookDataSource()
    static private let repository = BookRepositoryImpl(dataSource: dataSource)
    static private let useCases = BookUseCases(repository: repository)
  
    static func create() -> BookListView {
        let viewModel = BookListViewModel(bookUseCases: useCases)
        return BookListView(viewModel: viewModel)
    }
}
