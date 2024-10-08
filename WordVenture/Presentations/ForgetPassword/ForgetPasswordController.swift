//
//  ForgetPasswordController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/24/23.
//

import Foundation

@MainActor class ForgetPasswordController: ObservableObject {
    private let authService = AuthService()
    
    @Published var email = ""
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init() {
        fetchEmail()
    }
    
    private func fetchEmail() {
        isLoading = true
        
        Task {
            defer {
                isLoading = false
            }
            
            do {
                try await email = authService.getEmail() ?? "N/A"
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func sendResetEmail() {
        isLoading = true
        
        Task {
            defer {
                isLoading = false
            }
            
            do {
                try await authService.sendResetEmail(to: email)
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
}
