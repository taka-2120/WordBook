//
//  UserDataRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

class UserDataRepositoryImpl: UserDataRepository {
    
    func fetchUserData(userId: UUID) async throws -> UserData {
        return try await UserDataSource.fetchUserData(userId: userId)
    }
    
    func insertUserData(userId: UUID, username: String) async throws {
        return try await UserDataSource.insertUserData(userId: userId, username: username)
    }
    
    func updateUsername(userId: UUID, newUsername: String) async throws {
        return try await UserDataSource.updateUsername(userId: userId, newUsername: newUsername)
    }
    
    func updateVisibilities(userId: UUID, showPriority: Bool, showMissedCount: Bool) async throws {
        return try await UserDataSource.updateVisibilities(userId: userId, showPriority: showPriority, showMissedCount: showMissedCount)
    }
    
    func deleteUserData(userId: UUID) async throws {
        try await UserDataSource.deleteUserData(userId: userId)
    }
    
    func deleteUserAccount() async throws {
        try await UserDataSource.deleteUserAccount()
    }
}
