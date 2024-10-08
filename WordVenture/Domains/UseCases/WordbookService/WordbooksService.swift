//
//  WordbooksService.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

class WordbookService {
    
    private let authRepo: SupabaseAuthRepository
    private let userDataRepo: UserDataRepository
    private let wordbookRepo: WordbookRepository
    
    init() {
        self.authRepo = SupabaseAuthRepositoryImpl()
        self.userDataRepo = UserDataRepositoryImpl()
        self.wordbookRepo = WordbookRepositoryImpl()
    }
    
    func fetchWordbook() async throws -> [Wordbook] {
        let user = try await authRepo.fetchUser()
        return try await wordbookRepo.fetchWordbook(userId: user.id)
    }
    
    func addWordbook(name: String, color: String, original: String, translated: String) async throws -> [Wordbook] {
        let user = try await authRepo.fetchUser()
        return try await wordbookRepo.insertWordbook(userId: user.id, name: name, color: color, original: original, translated: translated)
    }
    
    func updateWordbook(bookId: UUID, name: String, color: String, original: String?, translated: String?, testAttempts: Int) async throws -> [Wordbook] {
        let user = try await authRepo.fetchUser()
        return try await wordbookRepo.updateWordbook(bookId: bookId, userId: user.id, name: name, color: color,
                                                     original: original, translated: translated, testAttempts: testAttempts)
    }
    
    func removeWordbook(target bookId: UUID) async throws -> [Wordbook] {
        let user = try await authRepo.fetchUser()
        return try await wordbookRepo.removeWordbook(userId: user.id, target: bookId)
    }
    
    
    func addWord(original: String, translated: String,
                 priority: Int, missed: Int, correct: Int, thumbnailUrl: String, imageUrls: [String],
                 synonyms: [String], antonyms: [String], examples: [String], imageSearchCount: Int, textGeneratedCount: Int, to wordbook: Wordbook) async throws {
        
        let newWord = Word(userId: wordbook.userId, wordId: UUID(), bookId: wordbook.bookId,
                           original: original, translated: translated, priority: priority, missed: missed, correct: correct,
                           thumbnailUrl: thumbnailUrl, imageUrls: imageUrls, synonyms: synonyms, antonyms: antonyms, examples: examples,
                           imageSearchCount: imageSearchCount, textGeneratedCount: textGeneratedCount)
        try await wordbookRepo.insertWord(word: newWord)
    }
    
    func updateWord(wordId: UUID, original: String, translated: String,
                    priority: Int, missed: Int, correct: Int, thumbnailUrl: String, imageUrls: [String],
                    synonyms: [String], antonyms: [String], examples: [String], imageSearchCount: Int, textGeneratedCount: Int, to wordbook: Wordbook) async throws {
        
        
        let newWord = Word(userId: wordbook.userId, wordId: wordId, bookId: wordbook.bookId,
                           original: original, translated: translated, priority: priority, missed: missed, correct: correct,
                           thumbnailUrl: thumbnailUrl, imageUrls: imageUrls, synonyms: synonyms, antonyms: antonyms, examples: examples,
                           imageSearchCount: imageSearchCount, textGeneratedCount: textGeneratedCount)
        
        try await wordbookRepo.updateWord(word: newWord)
    }
    
    func removeWord(for wordbook: Wordbook, target wordId: UUID) async throws {
        try await wordbookRepo.removeWord(userId: wordbook.userId, target: wordId)
    }
    
    func updateVisibilities(userId: UUID, showPriority: Bool, showMissedCount: Bool) async throws {
        try await userDataRepo.updateVisibilities(userId: userId, showPriority: showPriority, showMissedCount: showMissedCount)
    }
    
    func fetchVisibilities(for userId: UUID) async throws -> UserData {
        try await userDataRepo.fetchUserData(userId: userId)
    }
}
