//
//  SupabaseAuthRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Supabase
import GoTrue

actor AuthRepositoryImpl: AuthRepository {
    static func signUp(email: String, password: String) async throws {
        _ = try await client.auth.signUp(email: email, password: password)
        _ = try await retrieveSession()
    }
    
    static func signIn(email: String, password: String) async throws {
        _ = try await client.auth.signIn(email: email, password: password)
    }
    
    static func signOut() async throws {
        try await client.auth.signOut()
        await client.auth.initialize()
    }
    
    static func fetchUser() async throws -> User {
        return try await client.auth.session.user
    }
    
    // TODO: Consider the return value.
    static func retrieveSession() async throws -> Session {
        let session = try await client.auth.session
        return session
    }
    
    static func updatePassword(newPassword: String) async throws {
        try await client.auth.update(user: UserAttributes(password: newPassword))
    }
    
    static func updateEmail(newEmail: String) async throws {
        try await client.auth.update(user: UserAttributes(email: newEmail))
    }
    
    static func sendResetPasswordEmail(to email: String) async throws {
        try await client.auth.resetPasswordForEmail(email)
    }
}
