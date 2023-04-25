//
//  Words.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct Word: Equatable, Identifiable, Hashable, Codable {
    var id: UUID {
        self.wordId
    }
    
    var userId = UUID()
    var wordId = UUID()
    var bookId: UUID
    var original: String
    var translated: String
    var priority: Int
    var missed: Int
    var synonyms: [String]
    var antonyms: [String]
    var examples: [String]
}

struct WordAPIModel: Equatable, Hashable, Codable {
    var userId = UUID()
    var wordId = UUID()
    var bookId: UUID
    var original: String
    var translated: String
    var priority: Int
    var missed: Int
    var synonyms: [String]
    var antonyms: [String]
    var examples: [String]
}
