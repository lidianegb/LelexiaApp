//
//  CardButtonView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 07/01/25.
//

import SwiftUI

struct CardButtonView: View {
    var image: String
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
        }.shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 4)
    }
}

#Preview {
    CardButtonView(image: "wordsGame", action: {})
        .padding()
}
