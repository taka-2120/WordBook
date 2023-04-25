//
//  SupabaseAuthRepoInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase
import GoTrue

protocol SupabaseAuthRepoInterface {
    
    @MainActor
    func signUp(email: String, password: String) async throws -> User
    
    @MainActor
    func signIn(email: String, password: String) async throws -> User
    
    @MainActor
    func signOut() async throws
    
    @MainActor
    func retriveSession() async throws -> Session
    
}
