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
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var newPassword = ""
    @Published var reNewPassword = ""
    @Published var newEmail = ""
    @Published var isSignOutPromptShown = false
    
    init() {
        self.username = authService.getUsername()
        self.email = authService.getEmail()
    }
    
    func updateUsername(_ dismiss: DismissAction) {
        Task{ @MainActor in
            do {
                try await authService.updateUsername(newUsername: username)
                dismiss()
            } catch {
                print(error)
            }
        }
    }
    
    func updateEmail(_ dismiss: DismissAction) {
        Task{ @MainActor in
            do {
                try await authService.signIn(email: email, password: password)
                try await authService.updateEmail(newEmail: newEmail)
                dismiss()
            } catch {
                print(error)
            }
        }
    }
    
    func updatePassword(_ dismiss: DismissAction) {
        Task{ @MainActor in
            do {
                try await authService.signIn(email: email, password: password)
                if newPassword == reNewPassword {
                    try await authService.updatePassword(newPassword: newPassword)
                    dismiss()
                }
            } catch {
                print(error)
            }
        }
    }
    
//    func verifyEmail() {
//        Task{ @MainActor in
//            do {
//                try await authService.verifyEmail()
//            } catch {
//                print(error)
//            }
//        }
//    }
    
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
