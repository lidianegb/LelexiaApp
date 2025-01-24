//
//  BookDetailViewModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import Foundation
import SwiftUI
import AVFoundation

@Observable
@MainActor
class BookDetailViewModel: NSObject {
    var book: Book?
    var pageTextAttributed = AttributedString()
    var viewState: ViewState = .loading
    var nextBookID: UUID?
    var fontSize: CGFloat {
        didSet {
            UserDefaultsManager.shared.saveFontSize(fontSize)
        }
    }
    let speechManager = SpeechManager()
    @ObservationIgnored
    private var currentPage: Int = .zero
    private let bookUseCases: BookUseCases
    private let bookId: UUID
    
    init(bookUseCases: BookUseCases, bookID: UUID, nextBookID: UUID? = nil) {
        self.bookUseCases = bookUseCases
        self.bookId = bookID
        self.nextBookID = nextBookID
        fontSize = UserDefaultsManager.shared.loadFontSize()
        super.init()
    }
    
    func fetchData() async {
        viewState = .loading
        do {
            book = try await bookUseCases.fetchBook(from: bookId)
            if let paragraph = book?.getParagraph(by: currentPage)?.paragraph {
                pageTextAttributed = buildAttributedString(paragraph, raangeOfSpeechString: NSRange())
                viewState = .data
            }
        } catch {
            print("Error loading books: \(error)")
            viewState = .error
        }
    }
    
    func unlockNextBook() {
        guard let nextBookID else { return }
        Task {
            try await bookUseCases.unlockBook(nextBookID)
        }
    }
    
    func updatePage(_ newPage: Int) {
        guard let page = book?.getParagraph(by: newPage) else { return }
        pageTextAttributed = buildAttributedString(page.paragraph, raangeOfSpeechString: NSRange())
        currentPage = newPage
    }
    
    func didChangeFont() {
        if fontSize < 20 {
            fontSize += 1
        } else {
            fontSize = 16
        }
    }
    
    private func buildAttributedString(_ text: String, raangeOfSpeechString: NSRange) -> AttributedString {
        let nsAttributedString = NSMutableAttributedString(string: text)
        if speechManager.readingStatus == .playing {
            nsAttributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: raangeOfSpeechString)
            nsAttributedString.addAttribute(.underlineColor, value: UIColor.greenText, range: raangeOfSpeechString)

        }
        return AttributedString(nsAttributedString)
    }
}

// MARK: AVSpeechManager

extension BookDetailViewModel {
    func playReading() {
        guard let page = book?.getParagraph(by: currentPage) else { return }
        
        speechManager.play(text: page.paragraph) { [weak self] range in
            guard let self else { return }
            self.pageTextAttributed = self.buildAttributedString(page.paragraph, raangeOfSpeechString: range)
        }
    }
    
    func pauseReading() {
        speechManager.pause()
    }
    
    func stopReading() {
        speechManager.stop()
    }
}
