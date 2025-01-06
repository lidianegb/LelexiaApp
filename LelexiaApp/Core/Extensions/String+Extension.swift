//
//  String+Extension.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 03/01/25.
//

import SwiftUI

extension String {
    public var htmlToAttributed: AttributedString? {
        guard let nsAttributed = try? NSAttributedString(
            data: Data(self.utf8),
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        ),
              let attributed = try? AttributedString(nsAttributed, including: \.uiKit) else { return nil }
        return attributed
    }
}
