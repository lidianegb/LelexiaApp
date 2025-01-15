//
//  RoundedButtonView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 14/01/25.
//

import SwiftUI

struct RoundedButtonView: View {
    var image: String
    var action: (() -> Void)?
    var body: some View {
        Button {
            action?()
        } label: {
            VStack {
                Image(image)
                    .resizable()
                    .padding(Metrics.tiny)
                    .frame(width: 40, height: 40)
                    .background(Color.darkGreen)
                    .clipShape(.circle)
            }
        }
    }
}

#Preview {
    RoundedButtonView(image: "voltar")
}
