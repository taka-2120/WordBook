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
    
    @Published var username = ""
    @Published var email = ""
    
    @Published var isLoading = false
    @Published var isSignOutPromptShown = false
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init() {
        fetchInformation()
    }
    
    func fetchInformation() {
        self.username = authService.getUsername()
        self.email = authService.getEmail()
    }
    
    func signOut() {
        Task{ @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await authService.signOut()
                screenController.state = .auth
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func deleteAccount() {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await authService.deleteAccount()
                screenController.state = .auth
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
}
