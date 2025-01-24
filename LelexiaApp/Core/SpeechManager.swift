//
//  SpeechManager.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 24/01/25.
//

import AVFoundation
import SwiftUI

@MainActor
class SpeechManager: NSObject, ObservableObject {
    private let speechSynthesizer: AVSpeechSynthesizer
    private var onSpeechRangeUpdate: ((NSRange) -> Void)?

    @Published var readingStatus: ReadingStatus = .stopped
    
    init(delegate: AVSpeechSynthesizerDelegate? = nil) {
        self.speechSynthesizer = AVSpeechSynthesizer()
        super.init()
        self.speechSynthesizer.delegate = delegate ?? self
    }
    
    func setDelegate(_ delegate: AVSpeechSynthesizerDelegate) {
        self.speechSynthesizer.delegate = delegate
    }
    
    func play(text: String, language: String = "pt-BR", rate: Float = 0.3, onSpeechRangeUpdate: ((NSRange) -> Void)? = nil) {
        self.onSpeechRangeUpdate = onSpeechRangeUpdate
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: .mixWithOthers)
            try session.setActive(true)
        } catch {
            print("Error setting up audio session: \(error)")
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = rate
        speechSynthesizer.speak(utterance)
        readingStatus = .playing
    }
    
    func pause() {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.pauseSpeaking(at: .word)
            readingStatus = .paused
        }
    }
    
    func stop() {
        speechSynthesizer.stopSpeaking(at: .immediate)
        readingStatus = .stopped
    }
    
    func continueSpeaking() {
        if speechSynthesizer.isPaused {
            speechSynthesizer.continueSpeaking()
            readingStatus = .playing
        }
    }
}

extension SpeechManager: AVSpeechSynthesizerDelegate {
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.onSpeechRangeUpdate?(characterRange)
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

enum ReadingStatus {
    case playing
    case paused
    case stopped
}
