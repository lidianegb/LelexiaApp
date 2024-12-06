//
//  Item.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 06/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
