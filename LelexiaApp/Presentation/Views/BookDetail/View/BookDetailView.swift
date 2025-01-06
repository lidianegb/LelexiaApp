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
        Text("Hello, World!")
    }
}

#Preview {
    BookDetailView(viewModel: BookDetailViewModel())
}
