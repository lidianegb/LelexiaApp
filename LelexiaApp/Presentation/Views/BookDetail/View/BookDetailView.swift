//
//  BookDetailView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import SwiftUI

struct BookDetailView: View {
    @Bindable var viewModel: BookDetailViewModel
    @Environment(\.coordinator) var coordinator: NavigationCoordinator
    
    @State private var isReading: Bool = false
    @State private var continueReading: Bool = false
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            Image("book-list-background")
                .resizable()
                .overlay {
                    Color.white.opacity(0.6)
                }
                .ignoresSafeArea(.all)
            GeometryReader { _ in
                VStack(spacing: Metrics.medium) {
                    HStack(spacing: Metrics.little) {
                        RoundedButtonView(image: "voltar") {
                            coordinator.goBack()
                        }
                        Spacer()
                        if let title = viewModel.book?.title, viewModel.viewState == .data {
                            Text(title)
                                .font(.openDyslexic(size: Metrics.medium))
                                .foregroundStyle(Color.greenText)
                        }
                        
                        Spacer()
                        HStack(spacing: Metrics.nano) {
                            RoundedButtonView(image: "font-size") {
                                viewModel.didChangeFont()
                            }
                            RoundedButtonView(image: isReading ? "speaker.wave.2.fill" : "speaker.slash.fill", fromSystem: true) {
                                
                                switch viewModel.speechManager.readingStatus {
                                    case .playing:
                                        Task {
                                            viewModel.pauseReading()
                                        }
                                    case .paused, .stopped:
                                        Task {
                                            viewModel.playReading()
                                        }
                                }
                                isReading.toggle()
                                continueReading = isReading
                                viewModel.speechManager.readingStatus = isReading ? .playing : .paused
                            }
                        }
                    } .frame(maxWidth: .infinity)
                    switch viewModel.viewState {
                        case .loading:
                            ProgressView()
                                .frame(maxHeight: .infinity)
                        case .data:
                            if let book = viewModel.book {
                                BookDetailContentView(
                                    book: book,
                                    currentPage: $currentPage,
                                    fontSize: $viewModel.fontSize,
                                    pageText: $viewModel.pageTextAttributed
                                ) { newPage in
                                    viewModel.updatePage(newPage)
                                    viewModel.stopReading()
                                    continueReading = isReading
                                    isReading = false
                                    
                                    if continueReading {
                                        viewModel.playReading()
                                        isReading = true
                                    }
                                    
                                    if newPage == book.paragraphs.count - 1 {
                                        viewModel.unlockNextBook()
                                    }
                                }
                            }
                           
                        case .error:
                            ErrorView()
                    }
                }.padding(Metrics.small)
                
            }
        }
        .task {
            await viewModel.fetchData()
        } .onAppear {
            AppDelegate.orientationLock = .landscapeRight
        }
        .onDisappear {
            viewModel.stopReading()
            AppDelegate.orientationLock = .portrait
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BookDetailViewFactory.create(id: UUID())
}
