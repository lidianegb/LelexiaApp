//
//  LetterView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 25/01/25.
//

import SwiftUI

struct LetterView: View {
    @Binding var letter: Letter
    var scaleEffect: Bool
    var flipEffect: Bool
    var speakLetter: ((String) -> Void)?
    
    @State private var animateScale: Bool = false
    @State private var animateFlip: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Metrics.little)
                .stroke()
                .foregroundStyle(Color.darkGreen)
                
            RoundedRectangle(cornerRadius: Metrics.little)
                .foregroundStyle(letter.isFlipped ? Color.darkGreen : Color.lightGreen.opacity(0.4))
               
            if !letter.isFlipped {
                Text(letter.value)
                    .font(.openDyslexic(size: Metrics.large))
                    .foregroundStyle(Color.greenText)
                    .padding(.vertical, Metrics.little)
                    .padding(.horizontal, Metrics.large)
            }
        }
        .scaleEffect(animateScale ? 1.1 : 1)
        .rotation3DEffect(.degrees(animateFlip ? 180 : 0), axis: (x: 0, y: 1, z: 0))
         .onTapGesture {
             speakLetter?(letter.value)
             withAnimation(.easeOut) {
                 if scaleEffect {
                     animateScale.toggle()
                 }
                 if flipEffect {
                     letter.isFlipped.toggle()
                     animateFlip.toggle()
                 }
             } completion: {
                 withAnimation(.easeIn) {
                     if scaleEffect {
                         animateScale.toggle()
                     }
                 }
             }
         }
    }
}

#Preview {
    LetterView(letter: .constant(Letter(id: UUID(), value: "a", count: 0, isFlipped: false)), scaleEffect: false, flipEffect: true)
        .frame(width: 100, height: 100)
}
