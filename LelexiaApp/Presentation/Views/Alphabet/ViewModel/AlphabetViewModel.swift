//
//  AlphabetViewModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 27/01/25.
//

import Foundation

@MainActor
class AlphabetViewModel {

    private let speechManager = SpeechManager()

    func speakLetter(_ letter: String) {
        speechManager.play(text: letter)
    }
}
