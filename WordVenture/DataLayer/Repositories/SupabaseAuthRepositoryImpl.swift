//
//  SupabaseAuthRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase
import GoTrue

class SupabaseAuthRepositoryImpl: SupabaseAuthRepository {
    
    func signUp(email: String, password: String) async throws {
        try await SupabaseAuthDataSource.signUp(email: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws {
        try await SupabaseAuthDataSource.signIn(email: email, password: password)
    }
    
    func signOut() async throws {
        try await SupabaseAuthDataSource.signOut()
    }
    
    func fetchUser() async throws -> User {
        return try await SupabaseAuthDataSource.fetchUser()
    }
    
    func retriveSession() async throws -> Session {
        return try await SupabaseAuthDataSource.retriveSession()
    }
    
    func updatePassword(newPassword: String) async throws {
        try await SupabaseAuthDataSource.updatePassword(newPassword: newPassword)
    }
    
    func updateEmail(newEmail: String) async throws {
        try await SupabaseAuthDataSource.updateEmail(newEmail: newEmail)
    }
    
    func sendResetPasswordEmail(to email: String) async throws {
        try await SupabaseAuthDataSource.sendResetPasswordEmail(to: email)
    }
}
