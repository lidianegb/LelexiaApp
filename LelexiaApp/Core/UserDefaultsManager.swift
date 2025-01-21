//
//  UserDefaultsManager.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 18/01/25.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    private init() {}

    func saveFontSize(_ size: Double, key: String = "fontSize") {
        defaults.set(size, forKey: key)
    }

    func loadFontSize(key: String = "fontSize", defaultValue: CGFloat = 16.0) -> CGFloat {
        if defaults.object(forKey: key) != nil {
            return defaults.double(forKey: key)
        }
        return defaultValue
    }
}
