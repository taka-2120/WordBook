//
//  ChangeEmailController.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/16/23.
//

import SwiftUI

class ChangeEmailController: ObservableObject {
    private let authService = AuthService()
    
    @Published var email = ""
    @Published var newEmail = ""
    @Published var password = ""
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var isEmailConfirmationPromptShown = false
    @Published var errorType: ErrorMessage = .empty
    
    init() {
        self.email = authService.getEmail()
    }
    
    func updateEmailConfirmation() {
        if newEmail.isEmpty || password.isEmpty {
            errorType = .empty
            isErrorShown = true
            return
        }
        
        if !newEmail.isVailed(type: .emailRegex) {
            errorType = .invaildEmailFormat
            isErrorShown.toggle()
            return
        }
        
        isEmailConfirmationPromptShown = true
    }
    
    func updateEmail(_ dismiss: DismissAction) {
        Task{ @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await authService.signIn(email: email, password: password)
                try await authService.updateEmail(newEmail: newEmail)
                dismiss()
            } catch {
                print(error)
            }
        }
    }
}
