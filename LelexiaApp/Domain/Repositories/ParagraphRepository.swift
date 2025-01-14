//
//  ParagraphRepository.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 09/01/25.
//

import Foundation

protocol ParagraphRepository {
    func getParagraphs() async throws -> [Paragraph]
    func addParagraph(_ book: Paragraph) async throws
}
