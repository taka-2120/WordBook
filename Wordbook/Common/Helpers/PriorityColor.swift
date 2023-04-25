//
//  PriorityColor.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import SwiftUI

func getPriorityColor(priority: Int) -> Color {
    switch priority {
    case 0: return Color.clear
    case 1: return Color(.systemBlue)
    case 2: return Color(.systemOrange)
    case 3: return Color(.systemRed)
    default: return Color.clear
    }
}

func priorityDetector(priority: Int) -> (priority: String, foreground: Color) {
    switch priority {
    case 1: return ("Low", Color(.systemBlue))
    case 2: return ("Mid", Color(.systemOrange))
    case 3: return ("High", Color(.systemRed))
    default: return ("None", Color(.label))
    }
}
