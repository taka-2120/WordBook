//
//  UserDataRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

final class UserDataRepositoryImpl: UserDataRepository {
    static func fetchUserData(userId: UUID) async throws -> UserData {
        let query = await client.database
            .from(Table.users.rawValue)
            .select()
            .eq(column: "userId", value: userId)
            .single()

        let response: UserData = try await query.execute().value
        return response
    }
    
    static func insertUserData(userId: UUID, username: String) async throws {
        let userdata = UserData(userId: userId, username: username, showPriority: true, showMissedCount: true)

        try await client.database
                    .from(Table.users.rawValue)
                    .insert(values: userdata, returning: .representation)
                    .single()
                    .execute()
    }
    
    static func updateUsername(userId: UUID, newUsername: String) async throws {
        let oldUserData = try await fetchUserData(userId: userId)
        let userdata = UserData(userId: userId, username: newUsername,
                                showPriority: oldUserData.showPriority, 
                                showMissedCount: oldUserData.showMissedCount)
        try await client.database
            .from(Table.users.rawValue)
                    .update(values: userdata)
                    .eq(column: "userId", value: userId)
                    .single()
                    .execute()
    }
    
    static func updateVisibilities(userId: UUID, showPriority: Bool, showMissedCount: Bool) async throws {
        let oldUserData = try await fetchUserData(userId: userId)
        let userdata = UserData(userId: userId, username: oldUserData.username,
                                showPriority: showPriority, showMissedCount: showMissedCount)
        try await client.database
                    .from(Table.users.rawValue)
                    .update(values: userdata)
                    .eq(column: "userId", value: userId)
                    .single()
                    .execute()
    }
    
    static func deleteUserData(userId: UUID) async throws {
        try await client.database
            .from(Table.users.rawValue)
            .delete()
            .eq(column: "userId", value: userId)
            .execute()
    }
    
    static func deleteUserAccount() async throws {
        try await client.database
            .rpc(fn: "delete_user")
            .execute()
    }
}
