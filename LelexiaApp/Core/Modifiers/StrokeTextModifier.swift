//
//  StrokeTextModifier.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 14/01/25.
//

import SwiftUI

struct StrokeText: ViewModifier {
    var color: Color
    var lineWidth: Int
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
        
    }
}
