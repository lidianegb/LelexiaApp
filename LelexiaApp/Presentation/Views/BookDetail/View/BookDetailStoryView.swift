//
//  BookDetailStoryView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 15/01/25.
//

import SwiftUI

struct BookDetailStoryView: View {
    var image: String?
    @Binding var fontSize: CGFloat
    @Binding var text: AttributedString
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: Metrics.little) {
                if let image {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 4)
                        .clipShape(.circle)
                }
                Spacer()
                Text(text)
                .font(.openDyslexic(size: fontSize))
                .foregroundStyle(Color.greenText)
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    BookDetailStoryView(
        image: "h4-cena2",
        fontSize: .constant(16),
        text: .constant(AttributedString("O coelho e a cenoura perdida"))
    )
}
