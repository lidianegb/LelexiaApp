//
//  BookListContentView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 14/01/25.
//

import SwiftUI

struct BookListContentView: View {
    var books: [Book]
    var action: ((UUID) -> Void)?
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: Metrics.small, alignment: .center), count: 2)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: Metrics.small) {
                        ForEach(books) { book in
                            BookCardView(book: book)
                                .frame(height: (geometry.size.width / 2) * 1.3)
                                .onTapGesture {
                                    if book.locked { return }
                                    action?(book.id)
                                }
                        }
                    }
                    .padding(.horizontal, Metrics.small)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    var books: [Book] = [
        Book(id: UUID(), title: "O coelho e a cenoura perdida", cover:"h1-cena1", locked: false, backgroundColor: "#81B8CD", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "A formiga apressada", cover:"h2-cena1", locked: true, backgroundColor: "#5ED3B4", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "O gato curioso", cover:"h3-cena1", locked: true, backgroundColor: "#FCFF99", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "A estrela e a coruja", cover:"h4-cena1", locked: true, backgroundColor: "#ADA9DC", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "O peixinho corajoso", cover:"h5-cena1", locked: true, backgroundColor: "#96D2FB", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "O coelho e a cenoura perdida", cover:"h1-cena1", locked: true, backgroundColor: "#81B8CD", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "A formiga apressada", cover:"h2-cena1", locked: true, backgroundColor: "#5ED3B4", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "O gato curioso", cover:"h3-cena1", locked: true, backgroundColor: "#FCFF99", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "A estrela e a coruja", cover:"h4-cena1", locked: true, backgroundColor: "#ADA9DC", paragraphs: [], selectedWords: []
            ),
        Book(id: UUID(), title: "O peixinho corajoso", cover:"h5-cena1", locked: true, backgroundColor: "#96D2FB", paragraphs: [], selectedWords: []
            )
    ]
    return BookListContentView(books: books)
}
