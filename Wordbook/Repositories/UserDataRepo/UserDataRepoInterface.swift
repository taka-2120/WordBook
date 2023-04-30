//
//  UserDataRepoInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

protocol UserDataRepoInterface {
    
    @MainActor
    func insertUserData(userId: UUID, username: String) async throws
    
    @MainActor
    func fetchUserData(userId: UUID) async throws
    
}
