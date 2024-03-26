//
//  Haptics.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/7/23.
//

import Foundation
import UIKit

@MainActor func feedbackGenerator(type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
}

@MainActor func feedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let impactMed = UIImpactFeedbackGenerator(style: style)
    impactMed.impactOccurred()
}
