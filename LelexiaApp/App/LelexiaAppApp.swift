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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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

class AppDelegate: UIResponder, UIApplicationDelegate {
    static var orientationLock: UIInterfaceOrientationMask = .all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
