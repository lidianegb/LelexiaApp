//
//  BookDetailView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import SwiftUI

struct BookDetailView: View {
    @Bindable var viewModel: BookDetailViewModel
    var body: some View {
        VStack {
            if let book = viewModel.book {
                Text(book.title)
            }
        }.task {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    BookDetailViewFactory.create(id: UUID())
}
