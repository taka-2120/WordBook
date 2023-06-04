//
//  AuthController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

class AuthController: ObservableObject {
    
    private var screenController = ScreenController.shared
    private let authService = AuthService()
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    func signIn() {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await authService.signIn(email: email, password: password)
                screenController.state = .main
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func signUp() {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await authService.signUp(username: username, email: email, password: password)
                screenController.state = .main
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
}
