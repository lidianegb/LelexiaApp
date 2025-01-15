//
//  BookCardView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 14/01/25.
//

import SwiftUI

struct BookCardView: View {
    let book: Book
    
    var body: some View {
        ZStack {
            Color(hex: book.backgroundColor)
            VStack(spacing: .zero) {
                Text(book.title)
                    .font(.openDyslexic(size: Metrics.little))
                    .foregroundStyle(Color.greenText)
                    .lineLimit(2)
                    .strokeText(lineWidth: 8)
                    .padding(.horizontal, Metrics.small)
                    .padding(.vertical, Metrics.tiny)
                Spacer(minLength: Metrics.tiny)
                GeometryReader { geo in
                    Image(book.cover)
                        .resizable()
                        .clipShape(
                            UnevenRoundedRectangle(cornerRadii: .init(
                                topLeading: geo.size.width, topTrailing: geo.size.width), style: .circular)
                        ).shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 6)
                }
            }
        }
        .overlay {
            if book.locked {
                ZStack {
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: Metrics.small)
                            .fill(Color.black.opacity(0.6))
                        Image("lock")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geo.size.height / 5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
               
            }
        }
        .clipShape(.rect(cornerRadius: Metrics.small))
    }
}

#Preview {
    BookCardView(book: Book(
        id: UUID(),
        title: "O coelho e a cenoura",
        cover: "h1-cena1",
        locked: true,
        backgroundColor: "#81B8CD",
        paragraphs: [],
        selectedWords: [])
    )
    .frame(width: 230, height: 270)
    .padding()
}
