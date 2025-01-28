//
//  MemoryGameViewFactory.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

@MainActor
enum MemoryGameViewFactory {
    static private let dataSource = SwiftDataAlphabetDataSource()
    static private let repository = AlphabetRepositoryImpl(dataSource: dataSource)
    static private let useCases = AlphabetUseCases(repository: repository)
   
    static func create() -> MemoryGameView {
        let viewModel = MemoryGameViewModel(alphabetUseCases: useCases)
        return MemoryGameView(viewModel: viewModel)
    }
}
