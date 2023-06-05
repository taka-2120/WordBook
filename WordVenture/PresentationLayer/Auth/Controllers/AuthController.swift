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
                try validate(isSignUp: false)
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
                try validate(isSignUp: true)
                try await authService.signUp(username: username, email: email, password: password)
                screenController.state = .main
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    private func validate(isSignUp: Bool) throws {
        if username.isEmpty || email.isEmpty || password.isEmpty {
            throw CustomError.empty
        }
        
        if username.isVailed(type: .usernameRegex) && isSignUp {
            throw CustomError.longUsername
        }
        
        if email.isVailed(type: .emailRegex) {
            throw CustomError.invaildEmailFormat
        }
        
        if password.isVailed(type: .passwordRegex) {
            throw CustomError.weakPassword
        }
    }
}
