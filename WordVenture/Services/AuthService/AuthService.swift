//
//  AuthService.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

class AuthService: AuthServiceInterface {
    
    private let userDataRepo = UserDataRepo.shared
    private let authRepo = SupabaseAuthRepo.shared
    private let wordbookRepo = WordbookRepo.shared
    
    @MainActor
    func signUp(username: String, email: String, password: String) async throws {
        let user = try await authRepo.signUp(email: email, password: password)
        try await userDataRepo.insertUserData(userId: user.id, username: username)
        print("Success Sign Up")
        print(userDataRepo.userData)
    }
    
    @MainActor
    func signIn(email: String, password: String) async throws {
        let user = try await authRepo.signIn(email: email, password: password)
        try await userDataRepo.fetchUserData(userId: user.id)
        print("Success Sign In")
        print(userDataRepo.userData)
        try await wordbookRepo.fetchWordbook(userId: user.id)
        print(wordbookRepo.wordbooks)
    }
    
    @MainActor
    func signOut() async throws {
        try await authRepo.signOut()
    }
    
    @MainActor
    func isSignedIn() async throws {
        let session = try await authRepo.retriveSession()
        try await userDataRepo.fetchUserData(userId: session.user.id)
    }
    
    @MainActor
    func updateUsername(newUsername: String) async throws {
        if let id = authRepo.session?.user.id {
            try await userDataRepo.updateUsername(userId: id, newUsername: newUsername)
        }
    }
    
    @MainActor
    func updateEmail(newEmail: String) async throws {
        try await authRepo.updateEmail(newEmail: newEmail)
    }
    
    @MainActor
    func updatePassword(newPassword: String) async throws {
        try await authRepo.updatePassword(newPassword: newPassword)
    }
    
//    @MainActor
//    func verifyEmail() async throws {
//        if let email = authRepo.session?.user.email {
//            try await authRepo.sendVerifyEmail(to: email)
//        }
//    }
    
    func getEmail() -> String {
        authRepo.session?.user.email ?? "Not Registered"
    }
    
    func getUsername() -> String {
        userDataRepo.userData.username
    }
}
