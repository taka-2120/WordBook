//
//  TestCardController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/8/23.
//

import Foundation

class TestCardController: ObservableObject {
    @Published var isMissedShown = false
    @Published var isExamplesShown = false
    @Published var isImagesShown = false
    @Published var isDetailsShown = false
    @Published var isPrioritySheetShown = false
    @Published var isDismissAlertShown = false
    @Published var isCompletedShown = false
}
