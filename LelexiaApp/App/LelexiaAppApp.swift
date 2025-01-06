//
//  LelexiaAppApp.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 06/12/24.
//

import SwiftUI
import SwiftData

@main
struct LelexiaApp: App {
    @ObservedObject var coordinator = NavigationCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.navigationPath) {
                coordinator.view(for: .home)
                    .navigationDestination(for: Router.self) { route in
                        coordinator.view(for: route)
                    }
            }
        }
        .environment(\.coordinator, coordinator)
    }
}
