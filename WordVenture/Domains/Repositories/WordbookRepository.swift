//
//  WordbookRepoInterface.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

protocol WordbookRepository: AnyObject {
    
    func fetchWordbook(userId: UUID) async throws -> [Wordbook]
    func insertWordbook(userId: UUID, name: String, color: String, original: String, translated: String) async throws -> [Wordbook]
    func updateWordbook(bookId: UUID, userId: UUID, name: String, color: String, original: String?, translated: String?, testAttempts: Int) async throws -> [Wordbook]
    func removeWordbook(userId: UUID, target bookId: UUID) async throws -> [Wordbook]
    
    func insertWord(word: Word) async throws
    func updateWord(word: Word) async throws
    func removeWord(userId: UUID, target wordId: UUID) async throws
    
}
