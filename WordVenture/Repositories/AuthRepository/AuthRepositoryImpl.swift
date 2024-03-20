//
//  SupabaseAuthRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Supabase
import GoTrue

final class AuthRepositoryImpl: AuthRepository {
    func signUp(email: String, password: String) async throws {
        _ = try await client.auth.signUp(email: email, password: password)
        _ = try await retriveSession()
    }
    
    func signIn(email: String, password: String) async throws {
        _ = try await client.auth.signIn(email: email, password: password)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
        await client.auth.initialize()
    }
    
    func fetchUser() async throws -> User {
        return try await client.auth.session.user
    }
    
    // TODO: Consider the return value.
    func retriveSession() async throws -> Session {
        let session = try await client.auth.session
        return session
    }
    
    func updatePassword(newPassword: String) async throws {
        try await client.auth.update(user: UserAttributes(password: newPassword))
    }
    
    func updateEmail(newEmail: String) async throws {
        try await client.auth.update(user: UserAttributes(email: newEmail))
    }
    
    func sendResetPasswordEmail(to email: String) async throws {
        try await client.auth.resetPasswordForEmail(email)
    }
}
