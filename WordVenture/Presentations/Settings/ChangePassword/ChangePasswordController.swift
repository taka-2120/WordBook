//
//  ChangePasswordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/16/23.
//

import SwiftUI

class ChangePasswordController: ObservableObject {
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
        self.email = authService.getEmail()
    }
    
    func updatePassword(_ dismiss: DismissAction) {
        Task{ @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try validation()
                
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
