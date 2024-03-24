//
//  AuthService.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

class AuthService: AuthServiceInterface {
    func signUp(username: String, email: String, password: String) async throws {
        try await AuthRepositoryImpl.signUp(email: email, password: password)
        let user = try await AuthRepositoryImpl.fetchUser()
        try await UserDataRepositoryImpl.insertUserData(userId: user.id, username: username)
    }
    
    func signIn(email: String, password: String) async throws {
        try await AuthRepositoryImpl.signIn(email: email, password: password)
    }
    
    func signOut() async throws {
        try await AuthRepositoryImpl.signOut()
    }
    
    func deleteAccount() async throws {
        try await UserDataRepositoryImpl.deleteUserAccount()
    }
    
    func isSignedIn() async throws {
        _ = try await AuthRepositoryImpl.retrieveSession()
    }
    
    func updateUsername(newUsername: String) async throws {
        let user = try await AuthRepositoryImpl.fetchUser()
        try await UserDataRepositoryImpl.updateUsername(userId: user.id, newUsername: newUsername)
    }
    
    func updateEmail(newEmail: String) async throws {
        try await AuthRepositoryImpl.updateEmail(newEmail: newEmail)
    }
    
    func updatePassword(newPassword: String) async throws {
        try await AuthRepositoryImpl.updatePassword(newPassword: newPassword)
    }
    
    func getEmail() async throws -> String? {
        let user = try await AuthRepositoryImpl.fetchUser()
        return user.email
    }
    
    func getUsername() async throws -> String {
        let user = try await AuthRepositoryImpl.fetchUser()
        return try await UserDataRepositoryImpl.fetchUserData(userId: user.id).username
    }
    
    func sendResetEmail(to email: String) async throws {
        try await AuthRepositoryImpl.sendResetPasswordEmail(to: email)
    }
}
