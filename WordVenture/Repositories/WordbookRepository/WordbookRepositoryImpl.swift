//
//  WordbookRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

final class WordbookRepositoryImpl: WordbookRepository {
    
    static func fetchWordbook(userId: UUID) async throws -> [Wordbook] {
        let query = client.database
            .from(wordbooksTable)
            .select()
            .eq(column: "userId", value: userId)
        
        let response: [WordbookAPIModel] = try await query.execute().value
        
        var wordbooks = [Wordbook]()
        for wordbook in response {
            let words = try await fetchWords(userId: userId, bookId: wordbook.bookId)
            wordbooks.append(Wordbook(bookId: wordbook.bookId,
                                      userId: wordbook.userId,
                                      name: wordbook.name,
                                      color: wordbook.color,
                                      original: wordbook.original,
                                      translated: wordbook.translated,
                                      words: words,
                                      modifiedDate: wordbook.modifiedDate,
                                      testAttempts: wordbook.testAttempts))
        }
        wordbooks.sort(by: {$0.name < $1.name})
        
        return wordbooks
    }
    
    static func insertWordbook(userId: UUID, name: String, color: String, original: String, translated: String) async throws -> [Wordbook] {
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
        
        return try await fetchWordbook(userId: userId)
    }
    
    static func updateWordbook(bookId: UUID, userId: UUID, name: String, color: String, original: String?, translated: String?, testAttempts: Int) async throws -> [Wordbook] {
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
        
        return try await fetchWordbook(userId: userId)
    }
    
    static func removeWordbook(userId: UUID, target bookId: UUID) async throws -> [Wordbook] {
        try await client.database
            .from(wordbooksTable)
            .delete()
            .eq(column: "bookId", value: bookId)
            .execute()
        
        return try await fetchWordbook(userId: userId)
    }
    
    private static func fetchWords(userId: UUID, bookId: UUID) async throws -> [Word] {
        let query = client.database
            .from(wordsTable)
            .select()
            .eq(column: "bookId", value: bookId)
        
        let response: [WordAPIModel] = try await query.execute().value
        
        var words = [Word]()
        for word in response {
            words.append(Word(userId: userId,
                              wordId: word.wordId,
                              bookId: word.bookId,
                              original: word.original,
                              translated: word.translated,
                              priority: word.priority,
                              missed: word.missed,
                              correct: word.correct,
                              thumbnailUrl: word.thumbnailUrl,
                              imageUrls: word.imageUrls ?? [],
                              synonyms: word.synonyms,
                              antonyms: word.antonyms,
                              examples: word.examples,
                              imageSearchCount: word.imageSearchCount,
                              textGeneratedCount: word.textGeneratedCount))
        }
        
        return words
    }
    
    static func insertWord(word: Word) async throws {
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
    
    static func updateWord(word: Word) async throws {
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
    
    static func removeWord(userId: UUID, target wordId: UUID) async throws {
        try await client.database
            .from(wordsTable)
            .delete()
            .eq(column: "wordId", value: wordId)
            .execute()
    }
}
