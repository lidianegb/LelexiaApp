//
//  BookDetailLandscapeView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 15/01/25.
//

import SwiftUI

struct BookDetailLandscapeView: View {
    var image: String?
    @Binding var text: AttributedString
    
    var body: some View {
        HStack(spacing: Metrics.tiny) {
            if let image {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .clipShape(.circle)
            }
           // if let text {
                Text(text)
                    .font(.openDyslexic(size: Metrics.small))
           // }
        }
    }
}

#Preview {
    BookDetailLandscapeView(image: "h4-cena2", text: .constant(AttributedString("O coelho e a cenoura perdida")))
}
