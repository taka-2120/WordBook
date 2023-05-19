//
//  MockData.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation
import SwiftUI

let wordsMock: [Word] = [Word(userId: UUID(), wordId: UUID(), bookId: UUID(), original: "Hello", translated: "こんにちは", priority: 1, missed: 1, synonyms: [], antonyms: [], examples: [])]
let wordbooksMock: [Wordbook] = [Wordbook(bookId: UUID(), userId: UUID(), name: "Test", color: Color.blue.toHex(), words: wordsMock, modifiedDate: Date().ISO8601Format())]
