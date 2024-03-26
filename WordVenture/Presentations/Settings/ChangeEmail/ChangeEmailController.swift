//
//  ChangeEmailController.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/16/23.
//

import SwiftUI

@MainActor class ChangeEmailController: ObservableObject, Sendable {
    private let authService = AuthServiceImpl()
    
    @Published var email = ""
    @Published var newEmail = ""
    @Published var password = ""
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var isEmailConfirmationPromptShown = false
    @Published var errorMessage = ""
    
    init() {
        getEmail()
    }
    
    func getEmail() {
        Task{
            do {
                self.email = try await authService.getEmail() ?? "N/A"
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func updateEmailConfirmation() {
        do {
            try validation()
            
            isEmailConfirmationPromptShown = true
        } catch {
            errorMessage = error.localizedDescription
            isErrorShown = true
            print(error)
        }
    }
    
    func updateEmail(_ dismiss: DismissAction) {
        isLoading = true
        Task{
            defer {
                isLoading = false
            }
            
            do {
                try await authService.signIn(email: email, password: password)
                try await authService.updateEmail(newEmail: newEmail)
                dismiss()
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    private func validation() throws {
        if newEmail.isEmpty || password.isEmpty {
            throw CustomError.empty
        }
        
        if !newEmail.isVailed(type: .emailRegex) {
            throw CustomError.invalidEmailFormat
        }
    }
}
