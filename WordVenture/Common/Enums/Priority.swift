//
//  Priority.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/8/23.
//

import SwiftUI

enum Priority: CaseIterable {
    case high, moderate, low, no
}

extension Priority {
    var label: LocalizedStringKey {
        switch self {
        case .high:
            "high"
        case .moderate:
            "moderate"
        case .low:
            "low"
        case .no:
            "no"
        }
    }
    
    var symbol: String {
        switch self {
        case .high:
            "exclamationmark.3"
        case .moderate:
            "exclamationmark.2"
        case .low:
            "exclamationmark"
        case .no:
            "checkmark"
        }
    }
    
    var color: Color {
        switch self {
        case .high:
            Color.red
        case .moderate:
            Color.orange
        case .low:
            Color.blue
        case .no:
            Color.green
        }
    }
    
    var index: Int {
        switch self {
        case .high: 3
        case .moderate: 2
        case .low: 1
        case .no: 0
        }
    }
}

extension Int {
    func toPriority() -> Priority {
        switch self {
        case 1: return Priority.low
        case 2: return Priority.moderate
        case 3: return Priority.high
        default: return Priority.no
        }
    }
}
