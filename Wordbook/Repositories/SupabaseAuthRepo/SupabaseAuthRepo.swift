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
        self.session = response.session
        return response.session!.user
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
}
