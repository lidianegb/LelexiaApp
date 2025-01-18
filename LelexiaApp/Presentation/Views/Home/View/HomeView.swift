//
//  HomeView.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.coordinator) var coordinator: NavigationCoordinator
    @Bindable var viewModel: HomeViewModel
   
    var body: some View {
        ZStack {
            BackgroundHomeView()
            VStack {
                Image("logoname")
                    .resizable()
                    .scaledToFit()
                Spacer()
                CardButtonView(image: "books") {
                    coordinator.navigate(to: .bookList)
                }
                HStack(spacing: Metrics.medium) {
                    CardButtonView(image: "wordsGame") {
                        // go to words game
                    }
                    CardButtonView(image: "memoryGame") {
                        // go to memory game
                    }
                }
            }
            .padding([.horizontal, .bottom], Metrics.medium)
        }
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            AppDelegate.orientationLock = .portrait
        }
        .onDisappear {
            AppDelegate.orientationLock = .all
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
