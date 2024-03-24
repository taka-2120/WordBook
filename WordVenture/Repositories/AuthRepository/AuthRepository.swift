//
//  SupabaseAuthRepoInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Supabase
import GoTrue

protocol AuthRepository: Sendable {
    static func signUp(email: String, password: String) async throws
    static func signIn(email: String, password: String) async throws
    static func signOut() async throws
    static func fetchUser() async throws -> User
    static func retrieveSession() async throws -> Session
    static func updatePassword(newPassword: String) async throws
    static func updateEmail(newEmail: String) async throws
    static func sendResetPasswordEmail(to email: String) async throws
}
