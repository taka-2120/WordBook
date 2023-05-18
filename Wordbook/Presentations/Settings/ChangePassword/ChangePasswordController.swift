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
    @Published var errorType: ErrorMessage = .empty
    
    init() {
        self.email = authService.getEmail()
    }
    
    func updatePassword(_ dismiss: DismissAction) {
        if password.isEmpty || newPassword.isEmpty || reNewPassword.isEmpty {
            errorType = .empty
            isErrorShown.toggle()
            return
        }
        
        if newPassword != reNewPassword {
            errorType = .newPasswordNotMatched
            isErrorShown.toggle()
            return
        }
        
        if !newPassword.isVailed(type: .passwordRegex) {
            errorType = .weakPassword
            isErrorShown.toggle()
            return
        }
        
        Task{ @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
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
}
