//
//  Coordinator.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 11/12/24.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    var navigationPath: NavigationPath { get set }
    var activeSheet: Router? { get set }
    var activeFullScreenCover: Router? { get set }
    
    func navigate(to screen: Router)
    func presentSheet(_ screen: Router)
    func presentFullScreenCover(_ screen: Router)
    func dismissSheet()
    func dismissFullScreenCover()
    func goBack()
    func resetToRoot()
}
