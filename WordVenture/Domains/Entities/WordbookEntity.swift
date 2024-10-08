//
//  WordBooks.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import Foundation

struct Wordbook: Identifiable, Hashable, Codable, Sendable {
    var id: UUID {
        self.bookId
    }
    var bookId: UUID
    var userId: UUID
    var name: String
    var color: String
    var original: String?    // ISO Language Code
    var translated: String?  // ISO Language Code
    var words: [Word]
    var modifiedDate: String
    var testAttempts: Int
}

struct WordbookAPIModel: Hashable, Codable {
    var bookId: UUID
    var userId: UUID
    var name: String
    var color: String
    var original: String?    // ISO Language Code
    var translated: String?  // ISO Language Code
    var modifiedDate: String
    var testAttempts: Int
}
