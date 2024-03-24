//
//  UserDataRepoInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

protocol UserDataRepository: Sendable {
    static func fetchUserData(userId: UUID) async throws -> UserData
    static func insertUserData(userId: UUID, username: String) async throws
    static func updateUsername(userId: UUID, newUsername: String) async throws
    static func updateVisibilities(userId: UUID, showPriority: Bool, showMissedCount: Bool) async throws
    static func deleteUserData(userId: UUID) async throws
    static func deleteUserAccount() async throws
}
