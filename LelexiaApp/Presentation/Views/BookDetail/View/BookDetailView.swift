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
                                        
                                        switch viewModel.readingStatus {
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
                                        viewModel.readingStatus = isReading ? .playing : .paused
                                    }
                                }
                            } .frame(maxWidth: .infinity)
                            switch viewModel.viewState {
                                case .loading:
                                    ProgressView()
                                        .frame(maxHeight: .infinity)
                                case .data:
                                    if let book = viewModel.book {
                                        TabView(selection: $currentPage) {
                                            ForEach(0..<book.paragraphs.count, id: \.self) { index in
                                                if let paragraph = book.getParagraph(by: index) {
                                                    BookDetailLandscapeView(
                                                        image: paragraph.image,
                                                        fontSize: $viewModel.fontSize,
                                                        text: $viewModel.pageTextAttributed
                                                    )
                                                    .tag(index)
                                                    .animation(.easeInOut, value: currentPage)
                                                }
                                            }
                                        }
                                        .onChange(of: currentPage) { (_, newPage) in
                                            viewModel.updatePage(newPage)
                                            viewModel.stopReading()
                                            continueReading = isReading
                                            isReading = false
                                            
                                            if continueReading {
                                                viewModel.playReading()
                                                isReading = true
                                            }
                                        }
                                        .tabViewStyle(.page(indexDisplayMode: .always))
                                        .indexViewStyle(.page(backgroundDisplayMode: .never))
                                        .frame(maxWidth: .infinity)
                                        
                                        HStack {
                                            ForEach(0..<book.paragraphs.count, id: \.self) { index in
                                                Circle()
                                                    .fill(index == currentPage ? Color.darkGreen : Color.gray)
                                                    .frame(width: Metrics.little, height: Metrics.little)
                                                    .animation(.easeInOut, value: currentPage)
                                                    .onTapGesture {
                                                        currentPage = index
                                                    }
                                            }
                                        }
                                        .padding()
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
