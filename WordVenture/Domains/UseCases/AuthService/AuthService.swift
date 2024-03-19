//
//  AuthService.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

class AuthService: AuthServiceInterface {
    
    private let userDataRepo: UserDataRepository
    private let authRepo: SupabaseAuthRepository

    init() {
        self.userDataRepo = UserDataRepositoryImpl()
        self.authRepo = SupabaseAuthRepositoryImpl()
    }
    
    func signUp(username: String, email: String, password: String) async throws {
        try await authRepo.signUp(email: email, password: password)
        let user = try await authRepo.fetchUser()
        try await userDataRepo.insertUserData(userId: user.id, username: username)
    }
    
    func signIn(email: String, password: String) async throws {
        try await authRepo.signIn(email: email, password: password)
    }
    
    func signOut() async throws {
        try await authRepo.signOut()
    }
    
    func deleteAccount() async throws {
        try await userDataRepo.deleteUserAccount()
    }
    
    func isSignedIn() async throws {
        _ = try await authRepo.retriveSession()
    }
    
    func updateUsername(newUsername: String) async throws {
        let user = try await authRepo.fetchUser()
        try await userDataRepo.updateUsername(userId: user.id, newUsername: newUsername)
    }
    
    func updateEmail(newEmail: String) async throws {
        try await authRepo.updateEmail(newEmail: newEmail)
    }
    
    func updatePassword(newPassword: String) async throws {
        try await authRepo.updatePassword(newPassword: newPassword)
    }
    
    func getEmail() async throws -> String? {
        let user = try await authRepo.fetchUser()
        return user.email
    }
    
    func getUsername() async throws -> String {
        let user = try await authRepo.fetchUser()
        return try await userDataRepo.fetchUserData(userId: user.id).username
    }
    
    func sendResetEmail(to email: String) async throws {
        try await authRepo.sendResetPasswordEmail(to: email)
    }
}
