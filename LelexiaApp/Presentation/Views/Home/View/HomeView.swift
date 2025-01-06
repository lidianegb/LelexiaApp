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
    var htmlString = "<h1>Go to <font color=\"purple\">list stories view</font></h1>"
    @State var attributedString: AttributedString?
    var body: some View {
        VStack {
            if let attributedString {
                Button {
                    coordinator.navigate(to: .bookList)
                } label: {
                    Text(attributedString)
                }
            }
        } .onAppear {
            DispatchQueue.main.async {
                attributedString = htmlString.htmlToAttributed
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
