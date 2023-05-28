//
//  SupabaseAuthRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase
import GoTrue

class SupabaseAuthRepo: SupabaseAuthRepoInterface {
    
    static let shared = SupabaseAuthRepo()
    private init() {}
    
    var session: Session? = nil
    
    @MainActor
    func signUp(email: String, password: String) async throws -> User {
        let response = try await client.auth.signUp(email: email, password: password)
        self.session = try await retriveSession()
        return session!.user
    }
    
    @MainActor
    func signIn(email: String, password: String) async throws -> User {
        let session = try await client.auth.signIn(email: email, password: password)
        self.session = session
        return session.user
    }
    
    @MainActor
    func signOut() async throws {
        try await client.auth.signOut()
        session = nil
    }
    
    @MainActor
    func retriveSession() async throws -> Session {
        let session = try await client.auth.session
        self.session = session
        return session
    }
    
    @MainActor
    func updatePassword(newPassword: String) async throws {
        try await client.auth.update(user: UserAttributes(password: newPassword))
    }
    
    @MainActor
    func updateEmail(newEmail: String) async throws {
        try await client.auth.update(user: UserAttributes(email: newEmail))
    }
    
//    @MainActor
//    func sendVerifyEmail(to email: String) async throws {
//        let randomToken = Int.random(in: 100000...999999)
//        try await client.auth.verifyOTP(email: email, token: "\(randomToken)", type: .signup)
//    }
    
    @MainActor
    func sendResetPasswordEmail(to email: String) async throws {
        try await client.auth.resetPasswordForEmail(email)
    }
    
    func resetSession() {
        session = nil
    }
}
