//
//  AuthService.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

actor AuthService<AuthRepo: AuthRepository, UserDataRepo: UserDataRepository> {
    nonisolated func signUp(username: String, email: String, password: String) async throws {
        try await AuthRepo.signUp(email: email, password: password)
        let user = try await AuthRepo.fetchUser()
        try await UserDataRepo.insertUserData(userId: user.id, username: username)
    }
    
    func signIn(email: String, password: String) async throws {
        try await AuthRepo.signIn(email: email, password: password)
    }
    
    func signOut() async throws {
        try await AuthRepo.signOut()
    }
    
    func deleteAccount() async throws {
        try await UserDataRepo.deleteUserAccount()
    }
    
    nonisolated func isSignedIn() async throws {
        _ = try await AuthRepo.retrieveSession()
    }
    
    nonisolated func updateUsername(newUsername: String) async throws {
        let user = try await AuthRepo.fetchUser()
        try await UserDataRepo.updateUsername(userId: user.id, newUsername: newUsername)
    }
    
    func updateEmail(newEmail: String) async throws {
        try await AuthRepo.updateEmail(newEmail: newEmail)
    }
    
    func updatePassword(newPassword: String) async throws {
        try await AuthRepo.updatePassword(newPassword: newPassword)
    }
    
    nonisolated func getEmail() async throws -> String? {
        let user = try await AuthRepo.fetchUser()
        return user.email
    }
    
    nonisolated func getUsername() async throws -> String {
        let user = try await AuthRepo.fetchUser()
        return try await UserDataRepo.fetchUserData(userId: user.id).username
    }
    
    func sendResetEmail(to email: String) async throws {
        try await AuthRepo.sendResetPasswordEmail(to: email)
    }
}
