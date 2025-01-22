//
//  NavigationCoordinator.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import Foundation
import SwiftUI

@Observable
class NavigationCoordinator: Coordinator {
    var navigationPath = NavigationPath()
    var activeSheet: Router?
    var activeFullScreenCover: Router?
    
    func navigate(to screen: Router) {
        navigationPath.append(screen)
        print("Navigated to: \(screen.id)")
    }
    
    func presentSheet(_ screen: Router) {
        activeSheet = screen
        print("Presented sheet: \(screen.id)")
    }
    
    func presentFullScreenCover(_ screen: Router) {
        activeFullScreenCover = screen
        print("Presented full screen cover: \(screen.id)")
    }
    
    func dismissSheet() {
        print("Dismissed sheet: \(String(describing: activeSheet?.id))")
        activeSheet = nil
    }
    
    func dismissFullScreenCover() {
        print("Dismissed full screen cover: \(String(describing: activeFullScreenCover?.id))")
        activeFullScreenCover = nil
    }
    
    func goBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
            print("Went back. Current path count: \(navigationPath.count)")
        }
    }
    
    func resetToRoot() {
        navigationPath = NavigationPath()
        print("Reset to root.")
    }
    
    @ViewBuilder
    @MainActor
    func view(for route: Router) -> some View {
        switch route {
            case .home:
                HomeViewFactory.create()
            case .bookList:
                BookListViewFactory.create()
            case let .bookDetail(id, next):
                BookDetailViewFactory.create(id: id, nextBook: next)
        }
    }
}

private struct CoordinatorlKey: EnvironmentKey {
    static let defaultValue: NavigationCoordinator = NavigationCoordinator()
}

extension EnvironmentValues {
    var coordinator: NavigationCoordinator {
        get { self[CoordinatorlKey.self] }
        set { self[CoordinatorlKey.self] = newValue }
    }
}
