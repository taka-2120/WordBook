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
    
    init() {
        fetchEmail()
    }
    
    private func fetchEmail() {
        Task {
            do {
                try await email = authService.getEmail() ?? "N/A"
            } catch {
                // TODO: Handle this
                print(error)
            }
        }
    }
    
    func sendResetEmail() {
        Task {
            do {
                try await authService.sendResetEmail(to: email)
            } catch {
                // TODO: Handle this
                print(error)
            }
        }
    }
}
