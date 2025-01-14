//
//  WordRepository.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation

protocol WordRepository {
    func getWords() async throws -> [Word]
    func getWord(from id: UUID) async throws -> Word?
    func addWord(_ book: Word) async throws
}
