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
    
    func signIn() {
        Task { @MainActor in
            do {
                try await authService.signIn(email: email, password: password)
                screenController.state = .main
            } catch {
                print(error)
            }
        }
    }
    
    func signUp() {
        Task { @MainActor in
            do {
                try await authService.signUp(username: username, email: email, password: password)
                screenController.state = .main
            } catch {
                print(error)
            }
        }
    }
}
