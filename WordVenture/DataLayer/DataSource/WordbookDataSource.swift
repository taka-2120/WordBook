//
//  WordbookDataSource.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation
import Supabase

final class WordbooksDataSource: NSObject, Sendable {
    
    class func fetchWordbook(userId: UUID) async throws -> [WordbookAPIModel] {
        let query = client.database
            .from(wordbooksTable)
            .select()
            .eq(column: "userId", value: userId)
        
        let response: [WordbookAPIModel] = try await query.execute().value
        
        return response
    }
    
    class func insertWordbook(userId: UUID, name: String, color: String, original: String, translated: String) async throws {
        let wordbook = WordbookAPIModel(bookId: UUID(),
                                        userId: userId,
                                        name: name,
                                        color: color,
                                        original: original,
                                        translated: translated,
                                        modifiedDate: Date().ISO8601Format(),
                                        testAttempts: 0)
        
        try await client.database
            .from(wordbooksTable)
            .insert(values: wordbook, returning: .none)
            .execute()
    }
    
    class func updateWordbook(bookId: UUID, userId: UUID, name: String, color: String, original: String?, translated: String?, testAttempts: Int) async throws {
        let wordbook = WordbookAPIModel(bookId: bookId,
                                        userId: userId,
                                        name: name,
                                        color: color,
                                        original: original,
                                        translated: translated,
                                        modifiedDate: Date().ISO8601Format(),
                                        testAttempts: testAttempts)
        
        try await client.database
            .from(wordbooksTable)
            .update(values: wordbook)
            .eq(column: "bookId", value: bookId)
            .execute()
    }
    
    class func removeWordbook(userId: UUID, target bookId: UUID) async throws {
        try await client.database
            .from(wordbooksTable)
            .delete()
            .eq(column: "bookId", value: bookId)
            .execute()
    }
    
    class func fetchWords(userId: UUID, bookId: UUID) async throws -> [WordAPIModel] {
        let query = client.database
            .from(wordsTable)
            .select()
            .eq(column: "bookId", value: bookId)
        
        let response: [WordAPIModel] = try await query.execute().value
        
        return response
    }
    
    class func insertWord(word: Word) async throws {
        let word = WordAPIModel(wordId: UUID(),
                                userId: word.userId,
                                bookId: word.bookId,
                                original: word.original,
                                translated: word.translated,
                                priority: word.priority,
                                missed: word.missed,
                                correct: word.correct,
                                thumbnailUrl: word.thumbnailUrl,
                                imageUrls: word.imageUrls,
                                synonyms: word.synonyms,
                                antonyms: word.antonyms,
                                examples: word.examples,
                                imageSearchCount: word.imageSearchCount,
                                textGeneratedCount: word.textGeneratedCount)
        
        try await client.database
            .from(wordsTable)
            .insert(values: word, returning: .representation)
            .execute()
    }
    
    class func updateWord(word: Word) async throws {
        let word = WordAPIModel(wordId: word.wordId,
                                userId: word.userId,
                                bookId: word.bookId,
                                original: word.original,
                                translated: word.translated,
                                priority: word.priority,
                                missed: word.missed,
                                correct: word.correct,
                                thumbnailUrl: word.thumbnailUrl,
                                imageUrls: word.imageUrls,
                                synonyms: word.synonyms,
                                antonyms: word.antonyms,
                                examples: word.examples,
                                imageSearchCount: word.imageSearchCount,
                                textGeneratedCount: word.textGeneratedCount)
        
        try await client.database
            .from(wordsTable)
            .update(values: word)
            .eq(column: "wordId", value: word.wordId)
            .execute()
    }
    
    class func removeWord(target wordId: UUID) async throws {
        try await client.database
                .from(wordsTable)
                .delete()
                .eq(column: "wordId", value: wordId)
                .execute()
    }
    
}
