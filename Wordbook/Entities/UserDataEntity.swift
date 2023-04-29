//
//  UserDataEntity.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

struct UserData: Codable {
    var userId: UUID
    let username: String
}
