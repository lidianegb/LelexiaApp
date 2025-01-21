//
//  ErrorView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 21/01/25.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(spacing: Metrics.tiny) {
            Image(systemName: "x.circle.fill")
                .resizable()
                .foregroundStyle(.red)
                .frame(width: Metrics.huge, height: Metrics.huge)
            Text("Erro ao carregar os dados")
                .font(.openDyslexic(size: Metrics.small))
                .foregroundStyle(Color.greenText)
        }
    }
}

#Preview {
    ErrorView()
}
