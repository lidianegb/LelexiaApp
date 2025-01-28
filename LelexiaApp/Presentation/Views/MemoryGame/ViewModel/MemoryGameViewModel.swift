//
//  MemoryGameViewModel.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import Foundation
import SwiftData

@Observable
@MainActor
class MemoryGameViewModel {
    
    var alphabet: Alphabet?
    var selectedLetters: [String] = []
    
    @ObservationIgnored
    private let alphabetUseCases: AlphabetUseCases
    private var selectedGroupID: UUID?
  
    init(alphabetUseCases: AlphabetUseCases) {
        self.alphabetUseCases = alphabetUseCases
    }
    
    func loadAlphabet() async {
        do {
            alphabet = try await alphabetUseCases.fetchAlphabet()
        } catch {
            print("Error loading Alphabet: \(error)")
        }
    }
    
    // escolher nivel ao exibir imagens com quantidade
    
   
    // MARK: PRIVATE
    
    func startGame(for count: Int) {
        reloadAlphabet()
        guard let alphabet = alphabet, let selectedGroup = selectGroup(alphabet) else {
            return
        }
        selectedGroupID = selectedGroup.id
        let orderedAlphabet = orderedAlphabet(alphabet)
        
       
        self.selectedLetters = Array(selectLetters(count, selectedGroupLetters: selectedGroup.letters, orderedAlphabet: orderedAlphabet))
        
        updateAlphabet()
    }
    
    private func selectGroup(_ alphabet: Alphabet) -> GroupLetter? {
        alphabet.groups.min(by: { $0.count < $1.count })
    }
    
    private func orderedAlphabet(_ alphabet: Alphabet) -> [String] {
        alphabet.letters.sorted(by: { $0.count < $1.count }).compactMap { $0.value }
    }
    
    private func selectLetters(_ count: Int, selectedGroupLetters: [String], orderedAlphabet: [String]) -> Set<String> {
        var selectedLetters: Set<String> = Set(selectedGroupLetters)
        for letter in orderedAlphabet where selectedLetters.count < count {
            selectedLetters.insert(letter)
        }
        return selectedLetters
    }
    
    private func reloadAlphabet() {
        Task {
            await loadAlphabet()
        }
    }
    private func updateAlphabet() {
        Task {
            if let selectedGroupID {
                try await alphabetUseCases.incrementGroup(selectedGroupID)
            }
        }
        Task {
            for item in selectedLetters {
                try await alphabetUseCases.incrementLetter(item)
            }
        }
    }
}
