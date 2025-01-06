//
//  HomeViewFactory.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 13/12/24.
//

import Foundation

@MainActor
enum HomeViewFactory {
    static func create() -> HomeView {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
