//
//  AlphabetView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 27/01/25.
//

import SwiftUI

struct AlphabetView: View {
    var alphabetLetters: [Letter]
    
    @Environment(\.coordinator) var coordinator: NavigationCoordinator
    private let viewModel: AlphabetViewModel = AlphabetViewModel()
    private let columns = Array(repeating: GridItem(.flexible(), spacing: Metrics.medium, alignment: .center), count: 3)
    @State private var scaleEffect: Bool = false
    
    var body: some View {
        ZStack {
            Image("book-list-background")
                .resizable()
                .overlay {
                    Color.white.opacity(0.6)
                }
                .ignoresSafeArea(.all)
            VStack(spacing: Metrics.medium) {
                HStack(spacing: Metrics.little) {
                    RoundedButtonView(image: "voltar") {
                        coordinator.goBack()
                    }
                    Spacer()
                } .padding(Metrics.small)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: Metrics.medium) {
                        ForEach(alphabetLetters) { letter in
                            LetterView(letter: .constant(letter), scaleEffect: true, flipEffect: false) { letter in
                                viewModel.speakLetter(letter)
                            }
                        }
                    }.padding()
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AlphabetView(alphabetLetters: [
        Letter(id: UUID(), value: "a", count: 0),
        Letter(id: UUID(), value: "b", count: 0),
        Letter(id: UUID(), value: "c", count: 0),
        Letter(id: UUID(), value: "d", count: 0)
        ]
    )
}
