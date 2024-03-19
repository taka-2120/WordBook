//
//  SupabaseAuthRepoInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase
import GoTrue

protocol SupabaseAuthRepository: AnyObject {
    
    func signUp(email: String, password: String) async throws
    func signIn(email: String, password: String) async throws
    func signOut() async throws
    func fetchUser() async throws -> User
    func retriveSession() async throws -> Session
    func updatePassword(newPassword: String) async throws
    func updateEmail(newEmail: String) async throws
    func sendResetPasswordEmail(to email: String) async throws
    
}
