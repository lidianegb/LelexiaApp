//
//  BookListView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/12/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    
    @Bindable var viewModel: BookListViewModel
    @Environment(\.coordinator) var coordinator: NavigationCoordinator

    var body: some View {
        ZStack {
            Image("book-list-background")
                .resizable()
                .ignoresSafeArea(.all)
            BookListContentView(books: viewModel.books) { id in
                coordinator.navigate(to: .bookDetail(id: id))
            }
                .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 6)
        }
        .task {
            await viewModel.loadBooks()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                RoundedButtonView(image: "voltar") {
                    coordinator.goBack()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Histórias")
                    .font(.openDyslexic(size: Metrics.large))
                    .foregroundStyle(Color.greenText)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            AppDelegate.orientationLock = .portrait
        }
        .onDisappear {
            AppDelegate.orientationLock = .all
        }
    }
}

#Preview {
    BookListViewFactory.create()
}
