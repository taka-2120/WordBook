//
//  WordbooksService.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

class WordbookService {
    func fetchWordbook() async throws -> [Wordbook] {
        let user = try await AuthRepositoryImpl.fetchUser()
        return try await WordbookRepositoryImpl.fetchWordbook(userId: user.id)
    }
    
    func addWordbook(name: String, color: String, original: String, translated: String) async throws -> [Wordbook] {
        let user = try await AuthRepositoryImpl.fetchUser()
        return try await WordbookRepositoryImpl.insertWordbook(userId: user.id, name: name, color: color, original: original, translated: translated)
    }
    
    func updateWordbook(bookId: UUID, name: String, color: String, original: String?, translated: String?, testAttempts: Int) async throws -> [Wordbook] {
        let user = try await AuthRepositoryImpl.fetchUser()
        return try await WordbookRepositoryImpl.updateWordbook(bookId: bookId, userId: user.id, name: name, color: color,
                                                     original: original, translated: translated, testAttempts: testAttempts)
    }
    
    func removeWordbook(target bookId: UUID) async throws -> [Wordbook] {
        let user = try await AuthRepositoryImpl.fetchUser()
        return try await WordbookRepositoryImpl.removeWordbook(userId: user.id, target: bookId)
    }
    
    
    func addWord(original: String, translated: String,
                 priority: Int, missed: Int, correct: Int, thumbnailUrl: String, imageUrls: [String],
                 synonyms: [String], antonyms: [String], examples: [String], imageSearchCount: Int, textGeneratedCount: Int, to wordbook: Wordbook) async throws {
        
        let newWord = Word(userId: wordbook.userId, wordId: UUID(), bookId: wordbook.bookId,
                           original: original, translated: translated, priority: priority, missed: missed, correct: correct,
                           thumbnailUrl: thumbnailUrl, imageUrls: imageUrls, synonyms: synonyms, antonyms: antonyms, examples: examples,
                           imageSearchCount: imageSearchCount, textGeneratedCount: textGeneratedCount)
        try await WordbookRepositoryImpl.insertWord(word: newWord)
    }
    
    func updateWord(wordId: UUID, original: String, translated: String,
                    priority: Int, missed: Int, correct: Int, thumbnailUrl: String, imageUrls: [String],
                    synonyms: [String], antonyms: [String], examples: [String], imageSearchCount: Int, textGeneratedCount: Int, to wordbook: Wordbook) async throws {
        
        
        let newWord = Word(userId: wordbook.userId, wordId: wordId, bookId: wordbook.bookId,
                           original: original, translated: translated, priority: priority, missed: missed, correct: correct,
                           thumbnailUrl: thumbnailUrl, imageUrls: imageUrls, synonyms: synonyms, antonyms: antonyms, examples: examples,
                           imageSearchCount: imageSearchCount, textGeneratedCount: textGeneratedCount)
        
        try await WordbookRepositoryImpl.updateWord(word: newWord)
    }
    
    func removeWord(for wordbook: Wordbook, target wordId: UUID) async throws {
        try await WordbookRepositoryImpl.removeWord(userId: wordbook.userId, target: wordId)
    }
    
    func updateVisibilities(userId: UUID, showPriority: Bool, showMissedCount: Bool) async throws {
        try await UserDataRepositoryImpl.updateVisibilities(userId: userId, showPriority: showPriority, showMissedCount: showMissedCount)
    }
    
    func fetchVisibilities(for userId: UUID) async throws -> UserData {
        try await UserDataRepositoryImpl.fetchUserData(userId: userId)
    }
}
