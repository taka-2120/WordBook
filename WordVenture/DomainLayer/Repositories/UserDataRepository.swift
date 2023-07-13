//
//  UserDataRepoInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

protocol UserDataRepository: AnyObject {
    
    func insertUserData(userId: UUID, username: String) async throws
    func updateUsername(userId: UUID, newUsername: String) async throws
    func updateVisibilities(userId: UUID, showPriority: Bool, showMissedCount: Bool) async throws
    func fetchUserData(userId: UUID) async throws -> UserData
    func deleteUserData(userId: UUID) async throws
    func deleteUserAccount() async throws
    
}
