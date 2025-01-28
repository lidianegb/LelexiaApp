//
//  BookDetailContentView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 28/01/25.
//

import SwiftUI

struct BookDetailContentView: View {
    let book: Book
    @Binding var currentPage: Int
    @Binding var fontSize: CGFloat
    @Binding var pageText: AttributedString
    
    var onChangePage: ((Int) -> Void)?
    
    var body: some View {
        VStack(spacing: Metrics.little) {
            TabView(selection: $currentPage) {
                ForEach(0..<book.paragraphs.count, id: \.self) { index in
                    if let paragraph = book.getParagraph(by: index) {
                        BookDetailStoryView(
                            image: paragraph.image,
                            fontSize: $fontSize,
                            text: $pageText
                        )
                        .tag(index)
                        .animation(.easeInOut, value: currentPage)
                    }
                }
            }
            .onChange(of: currentPage) { (_, newPage) in
                onChangePage?(newPage)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
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
            }.padding()
        }
    }
}

#Preview {
    BookDetailContentView(
        book: Book(
            id: UUID(),
            title: "O coelho e a cenoura perdida",
            cover: "h1-cena1",
            locked: false,
            backgroundColor: "#81B8CD",
            paragraphs: [
                Paragraph(
                id: UUID(),
                index: 0,
                paragraph: "Totó era um coelho que vivia em uma linda horta cheia de cenouras. Um dia, ele plantou uma cenoura especial e esperou pacientemente que ela crescesse.",
                image: "h1-cena1"
                ),
                Paragraph(
                    id: UUID(),
                    index: 0,
                    paragraph: "Totó era um coelho que vivia em uma linda horta cheia de cenouras. Um dia, ele plantou uma cenoura especial e esperou pacientemente que ela crescesse.",
                    image: "h1-cena1"
                ),
                Paragraph(
                    id: UUID(),
                    index: 0,
                    paragraph: "Totó era um coelho que vivia em uma linda horta cheia de cenouras. Um dia, ele plantou uma cenoura especial e esperou pacientemente que ela crescesse.",
                    image: "h1-cena1"
                )
            ],
            selectedWords: []
        ),
        currentPage: .constant(0),
        fontSize: .constant(14),
        pageText: .constant(AttributedString(stringLiteral: "Totó era um coelho que vivia em uma linda horta cheia de cenouras. Um dia, ele plantou uma cenoura especial e esperou pacientemente que ela crescesse."))
    )
}
