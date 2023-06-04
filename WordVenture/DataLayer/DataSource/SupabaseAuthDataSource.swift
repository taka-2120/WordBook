//
//  SupabaseAuthDataSource.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation
import Supabase
import GoTrue

class SupabaseAuthDataSource: NSObject {
    
    class func signUp(email: String, password: String) async throws {
        _ = try await client.auth.signUp(email: email, password: password)
        _ = try await retriveSession()
    }
    
    class func signIn(email: String, password: String) async throws {
        _ = try await client.auth.signIn(email: email, password: password)
    }
    
    class func signOut() async throws {
        try await client.auth.signOut()
    }
    
    class func fetchUser() async throws -> User {
        return try await client.auth.session.user
    }
    
    // TODO: Consider the return value.
    class func retriveSession() async throws -> Session {
        let session = try await client.auth.session
        return session
    }
    
    class func updatePassword(newPassword: String) async throws {
        try await client.auth.update(user: UserAttributes(password: newPassword))
    }
    
    class func updateEmail(newEmail: String) async throws {
        try await client.auth.update(user: UserAttributes(email: newEmail))
    }
    
    class func sendResetPasswordEmail(to email: String) async throws {
        try await client.auth.resetPasswordForEmail(email)
    }
}
