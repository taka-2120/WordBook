//
//  DeleteAccountController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/28/23.
//

import SwiftUI

class DeleteAccountController: ObservableObject {
    private var screenController = ScreenController.shared
    private let authService = AuthService()
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var isDeleteWarningShown = false
    @Published var isDeleteFinalConfirmationShown = false
    @Published var errorMessage = ""
    
    func confirmAccount() {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await authService.signIn(email: email, password: password)
                isDeleteWarningShown = true
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func deleteAccount(_ dismiss: DismissAction) {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await authService.deleteAccount()
                dismiss()
                screenController.state = .auth
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
}
