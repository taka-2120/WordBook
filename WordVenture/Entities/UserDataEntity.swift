//
//  UserDataEntity.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

struct UserData: Codable, Sendable {
    var userId: UUID
    var username: String
    var showPriority: Bool
    var showMissedCount: Bool
}
