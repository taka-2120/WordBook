//
//  AuthServiceInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

protocol AuthServiceInterface {
    
    @MainActor
    func signUp(username: String, email: String, password: String) async throws
    
    @MainActor
    func signIn(email: String, password: String) async throws
    
    @MainActor
    func signOut() async throws
    
    @MainActor
    func isSignedIn() async throws
    
}
