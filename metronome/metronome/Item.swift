//
//  Item.swift
//  metronome
//
//  Created by Moe Amadou on 5/26/25.
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
