//
//  CardController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/7/23.
//

import Foundation

class CardController: ObservableObject {
    @Published var isMissedShown = false
    @Published var isCardModeShown = false
    @Published var isAlwaysImageShown = false
}
