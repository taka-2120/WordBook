//
//  AuthController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import SwiftUI

@MainActor
class AuthController: LoadablePresenter {
    private let screenController = ScreenController.shared
    @StateObject var dialogManager = DialogManager()
    private let authService = AuthServiceImpl()
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        loadingTask { [self] in
            do {
                try validate(isSignUp: false)
                try await authService.signIn(email: email, password: password)
                screenController.state = .main
            } catch {
                dialogManager.showErrorDialog(message: "\(error.localizedDescription)")
            }
        }
    }
    
    func signUp() {
        loadingTask { [self] in
            do {
                try validate(isSignUp: true)
                try await authService.signUp(username: username, email: email, password: password)
                screenController.state = .main
            } catch {
                dialogManager.showErrorDialog(message: "\(error.localizedDescription)")
            }
        }
    }
    
    private func validate(isSignUp: Bool) throws {
        if username.isEmpty && isSignUp || email.isEmpty || password.isEmpty {
            throw CustomError.empty
        }
        
        if !username.isVailed(type: .usernameRegex) && isSignUp {
            throw CustomError.longUsername
        }
        
        if !email.isVailed(type: .emailRegex) {
            throw CustomError.invalidEmailFormat
        }
        
        if !password.isVailed(type: .passwordRegex) && isSignUp {
            throw CustomError.weakPassword
        }
    }
}
