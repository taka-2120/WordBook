//
//  SettingsController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/25/23.
//

import SwiftUI

class SettingsController: ObservableObject {
    
    private var screenController = ScreenController.shared
    private let authService = AuthService()
    
    @Published var settingsPathes: [SettingsNavStack] = []
    
    func signOut() {
        Task{ @MainActor in
            do {
                try await authService.signOut()
                screenController.state = .auth
            } catch {
                print(error)
            }
        }
    }
}
