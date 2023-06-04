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
        Task{ @MainActor in
            do {
                self.username = try await authService.getUsername()
                self.email = try await authService.getEmail() ?? "N/A"
            } catch {
                print(error)
            }
        }
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
