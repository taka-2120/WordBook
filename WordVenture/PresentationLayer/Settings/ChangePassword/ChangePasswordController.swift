//
//  ChangePasswordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/16/23.
//

import SwiftUI

@MainActor class ChangePasswordController: ObservableObject, Sendable {
    private let authService = AuthService()
    
    @Published var email = ""
    @Published var password = ""
    @Published var newPassword = ""
    @Published var reNewPassword = ""
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var isEmailConfirmationPromptShown = false
    @Published var errorMessage = ""
    
    init() {
        getEmail()
    }
    
    func getEmail() {
        Task{ @MainActor in
            do {
                self.email = try await authService.getEmail() ?? "N/A"
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func updatePassword(_ dismiss: DismissAction) {
        isLoading = true
        Task{ @MainActor in
            defer {
                isLoading = false
            }
            
            do {
                try validation()
                
                try await authService.signOut()
                try await authService.signIn(email: email, password: password)
                
                try await authService.updatePassword(newPassword: newPassword)
                dismiss()
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    private func validation() throws {
        if password.isEmpty || newPassword.isEmpty || reNewPassword.isEmpty {
            throw CustomError.empty
        }
        
        if newPassword != reNewPassword {
            throw CustomError.newPasswordNotMatched
        }
        
        if !newPassword.isVailed(type: .passwordRegex) {
            throw CustomError.weakPassword
        }
    }
}
