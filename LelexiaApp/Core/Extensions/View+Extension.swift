//
//  View+Extension.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 14/01/25.
//

import Foundation
import SwiftUI

extension View {
    public func strokeText(color: Color = .white, lineWidth: Int = 5) -> some View {
        self.modifier(StrokeText(color: color, lineWidth: lineWidth))
    }
}
