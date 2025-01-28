//
//  AlphabetRepository.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import Foundation

protocol AlphabetRepository {
    func getAlphabet() async throws -> Alphabet?
    func incrementLetter(_ value: String) async throws
    func incrementGroup(_ id: UUID) async throws
}
