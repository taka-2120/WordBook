//
//  WordbookRepoInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

protocol WordbookRepository: Sendable {
    
    static func fetchWordbook(userId: UUID) async throws -> [Wordbook]
    static func insertWordbook(userId: UUID, name: String, color: String, original: String, translated: String) async throws -> [Wordbook]
    static func updateWordbook(bookId: UUID, userId: UUID, name: String, color: String, original: String?, translated: String?, testAttempts: Int) async throws -> [Wordbook]
    static func removeWordbook(userId: UUID, target bookId: UUID) async throws -> [Wordbook]
    
    static func insertWord(word: Word) async throws
    static func updateWord(word: Word) async throws
    static func removeWord(userId: UUID, target wordId: UUID) async throws
    
}
