//
//  BookDetailViewModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import Foundation
import SwiftUI
import AVFoundation

enum ReadingStatus {
    case playing
    case paused
    case stopped
}

@Observable
@MainActor
class BookDetailViewModel: NSObject {
    var book: Book?
    var pageTextAttributed = AttributedString()
    var readingStatus: ReadingStatus = .stopped
   
    @ObservationIgnored
    private var currentPage: Int = .zero
    private let bookUseCases: BookUseCases
    private let bookId: UUID
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    init(bookUseCases: BookUseCases, bookID: UUID) {
        self.bookUseCases = bookUseCases
        self.bookId = bookID
        super.init()
        self.speechSynthesizer.delegate = self
    }
    
    func fetchData() async {
        do {
            book = try await bookUseCases.fetchBook(from: bookId)
            if let paragraph = book?.getParagraph(by: currentPage)?.paragraph {
                pageTextAttributed = buildAttributedString(paragraph, raangeOfSpeechString: NSRange())
            }
        } catch {
            print("Error loading books: \(error)")
        }
    }
    
    func updatePage(_ newPage: Int) {
        guard let page = book?.getParagraph(by: newPage) else { return }
        pageTextAttributed = buildAttributedString(page.paragraph, raangeOfSpeechString: NSRange())
        currentPage = newPage
    }
    
    private func buildAttributedString(_ text: String, raangeOfSpeechString: NSRange) -> AttributedString {
        let nsAttributedString = NSMutableAttributedString(string: text)
        if readingStatus == .playing {
            nsAttributedString.addAttribute(.backgroundColor, value: UIColor.yellow, range: raangeOfSpeechString)
        }
        return AttributedString(nsAttributedString)
    }
}

extension BookDetailViewModel: AVSpeechSynthesizerDelegate {
    func playReading() {
        readingStatus = .playing
        if speechSynthesizer.isPaused {
            speechSynthesizer.continueSpeaking()
            return
        }
        guard let page = book?.getParagraph(by: currentPage) else { return }
        
        let utterance = AVSpeechUtterance(string: page.paragraph)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        utterance.rate = 0.4
        speechSynthesizer.speak(utterance)
    }
    
    func pauseReading() {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.pauseSpeaking(at: .word)
            readingStatus = .paused
        }
    }
    
    func stopReading() {
        speechSynthesizer.stopSpeaking(at: .immediate)
        readingStatus = .stopped
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self, let page = book?.getParagraph(by: currentPage) else { return }
            self.pageTextAttributed = buildAttributedString(page.paragraph, raangeOfSpeechString: characterRange)
        }
    }
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.readingStatus = .paused
        }
    }
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.readingStatus = .playing
        }
    }
}
