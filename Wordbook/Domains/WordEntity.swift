//
//  Words.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct Words: Equatable, Identifiable {
    var id = UUID()
    var originalWord: String
    var translatedWord: String
    var priority: Int
    var missed: Int
}
