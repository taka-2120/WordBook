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
    @Published var errorType: ErrorMessage = .empty
    
    init() {
        self.username = authService.getUsername()
    }
    
    func updateUsername(_ dismiss: DismissAction) {
        if username.isEmpty {
            errorType = .empty
            isErrorShown.toggle()
            return
        }
        
        if !username.isVailed(type: .usernameRegex) {
            errorType = .longUsername
            isErrorShown.toggle()
            return
        }
        
        Task{ @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await authService.updateUsername(newUsername: username)
                dismiss()
            } catch {
                print(error)
            }
        }
    }
}
