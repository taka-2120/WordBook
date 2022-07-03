//
//  CommonFunc.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

func wordIndexDetector(words: [Words], id: UUID) -> Int {
    for i in 0 ... words.count - 1 {
        if words[i].id == id {
            return i
        }
    }
    return words.count
}

func priorityDetector(priority: Int) -> Color {
    switch priority {
    case 0: return Color.clear
    case 1: return Color(.systemBlue)
    case 2: return Color(.systemOrange)
    case 3: return Color(.systemRed)
    default: return Color.clear
    }
}
