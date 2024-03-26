//
//  DeleteAccountController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/28/23.
//

import SwiftUI

@MainActor class DeleteAccountController: ObservableObject, Sendable {
    private var screenController = ScreenController.shared
    private let authService = AuthServiceImpl()
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var isDeleteWarningShown = false
    @Published var isDeleteFinalConfirmationShown = false
    @Published var errorMessage = ""
    
    func confirmAccount() {
        isLoading = true
        Task {
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
        isLoading = true
        Task {
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
