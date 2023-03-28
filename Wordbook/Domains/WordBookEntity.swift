//
//  WordBooks.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import Foundation

struct WordBooks {
    var id = UUID()
    var name: String
    var words: [Words]
    var modifiedDate: Date
}
