//
//  BackgroundHomeView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 06/01/25.
//

import SwiftUI

struct BackgroundHomeView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: .zero) {
                ZStack {
                    Color.lightGreen.edgesIgnoringSafeArea(.all)
                }.frame(height: geo.size.height / 3)
                ZStack(alignment: .center) {
                    GeometryReader { geo in
                        Color.lightGreen.edgesIgnoringSafeArea(.all)
                        UnevenRoundedRectangle(cornerRadii: .init(
                            topLeading: geo.size.width, topTrailing: geo.size.width), style: .circular)
                        .foregroundStyle(Color.lightBlue)
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width * 1.5)
                        .offset(x: -geo.frame(in: .local).midX * 0.5)
                        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 6)
                    }
                }
            }}
    }
}

#Preview {
    BackgroundHomeView()
}
