//
//  BookListViewFactory.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 13/12/24.
//

import Foundation

@MainActor
enum BookListViewFactory {
    static private let dataSource = SwiftDataBookDataSource.shared
    static private let repository = BookRepositoryImpl(dataSource: dataSource)
    static private let useCases = BookUseCases(repository: repository)
    static private let viewModel = BookListViewModel(bookUseCases: useCases)
    
    static func create() -> BookListView {
        return BookListView(viewModel: viewModel)
    }
}
