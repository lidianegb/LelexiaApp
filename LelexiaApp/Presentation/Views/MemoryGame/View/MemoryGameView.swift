//
//  MemoryGameView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import SwiftUI

struct MemoryGameView: View {
    
    @Bindable var viewModel: MemoryGameViewModel
    @Environment(\.coordinator) var coordinator: NavigationCoordinator
    
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.selectedLetters, id: \.self) { item in
                    Text(item)
                }
            }
            
            Button {
              //  viewModel.generateLetters(for: 6)
            } label: {
                Text("gerar sequencia 6")
            }
        }
        Text("Hello, World!")
            .task {
                await viewModel.loadAlphabet()
            }
    }
}

#Preview {
    MemoryGameViewFactory.create()
}
