//
//  Words.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI
import Foundation

struct Word: Equatable, Identifiable, Hashable, Codable, Sendable {
    var id: UUID {
        self.wordId
    }
    
    var userId: UUID
    var wordId: UUID
    var bookId: UUID
    var original: String
    var translated: String
    var priority: Int
    var missed: Int
    var correct: Int
    var thumbnailUrl: String
    var imageUrls: [String]
    var synonyms: [String]
    var antonyms: [String]
    var examples: [String]
    var imageSearchCount: Int
    var textGeneratedCount: Int
}

struct WordAPIModel: Equatable, Hashable, Codable {
    var wordId: UUID
    var userId: UUID
    var bookId: UUID
    var original: String
    var translated: String
    var priority: Int
    var missed: Int
    var correct: Int
    var thumbnailUrl: String
    var imageUrls: [String]?
    var synonyms: [String]
    var antonyms: [String]
    var examples: [String]
    var imageSearchCount: Int
    var textGeneratedCount: Int
}
