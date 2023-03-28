//
//  WordIndex.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

func getWordIndex(words: [Words], id: UUID) -> Int {
    for i in 0 ... words.count - 1 {
        if words[i].id == id {
            return i
        }
    }
    return words.count
}
