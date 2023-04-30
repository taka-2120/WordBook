//
//  UserDataRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

class UserDataRepo: UserDataRepoInterface {
    
    static let shared = UserDataRepo()
    private init() {}
    
    var userData = UserData(userId: UUID(), username: "")
    
    @MainActor
    func insertUserData(userId: UUID, username: String) async throws {
        let userdata = UserData(userId: userId, username: username)
        let query = client.database
                    .from(usersTable)
                    .insert(values: userdata, returning: .representation)
                    .single()
        
        let response: UserData = try await query.execute().value
        
        userData = response
    }
    
    @MainActor
    func fetchUserData(userId: UUID) async throws {
        let query = client.database
                    .from(usersTable)
                    .select()
                    .eq(column: "userId", value: userId)
                    .single()
        
        let response: UserData = try await query.execute().value
        
        userData = response
    }
}
