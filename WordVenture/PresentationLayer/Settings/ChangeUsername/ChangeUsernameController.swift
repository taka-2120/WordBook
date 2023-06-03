//
//  ChangeUsernameController.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/16/23.
//

import SwiftUI

class ChangeUsernameController: ObservableObject {
    private let authService = AuthService()
    
    @Published var username = ""
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init() {
        getUsername()
    }
    
    func getUsername() {
        Task{ @MainActor in
            do {
                self.username = try await authService.getUsername()
            } catch {
                print(error)
            }
        }
    }
    
    func updateUsername(_ dismiss: DismissAction) {
        Task{ @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try validation()
                
                try await authService.updateUsername(newUsername: username)
                dismiss()
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    private func validation() throws {
        if username.isEmpty {
            throw CustomError.empty
        }
        
        if !username.isVailed(type: .usernameRegex) {
            throw CustomError.longUsername
        }
    }
}
