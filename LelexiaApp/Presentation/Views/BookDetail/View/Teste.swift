//
//  Teste.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 17/01/25.
//

import SwiftUI
import AVFoundation
import Foundation

class StoryViewModel: NSObject, ObservableObject {
    @Published var storyText: String
    @Published var wordRange = NSRange()
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    init(storyText: String) {
        self.storyText = storyText
        super.init()
        self.speechSynthesizer.delegate = self
    }
    
    public func buildAttributedString() -> AttributedString {
        let nsAttributedString = NSMutableAttributedString(string: storyText)
    
        nsAttributedString.addAttribute(.backgroundColor, value: UIColor.yellow, range: wordRange)

        return AttributedString(nsAttributedString)
    }
}

extension StoryViewModel: AVSpeechSynthesizerDelegate {
    
    func startReading() {
        let utterance = AVSpeechUtterance(string: storyText)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        utterance.rate = 0.4
        speechSynthesizer.speak(utterance)
    }
    
    func stopReading() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
          DispatchQueue.main.async {
              self.wordRange = characterRange
          }
      }
}

struct StoryView: View {
    @StateObject private var viewModel = StoryViewModel(storyText: "Era uma vez uma menina chamada Maria que vivia em uma floresta mágica.")
    
    var body: some View {
        VStack {
            ScrollView {
                TextWithHighlightedWord(fullText: viewModel.buildAttributedString())
                    .padding()
                    .font(.title2)
            }
            Button("Play Story") {
                viewModel.startReading()
            }
            .padding()
            .font(.headline)
        }
        .onDisappear {
            viewModel.stopReading()
        }
    }
}

struct TextWithHighlightedWord: View {
    let fullText: AttributedString
    
    var body: some View {
        VStack {
            Text(fullText)
            Image(systemName: "speaker.wave.2.fill")
            Image(systemName: "speaker.slash.fill")
        }
    }
}

#Preview {
    StoryView()
}
