//
//  WordsController.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import SwiftUI

class WordsController: ObservableObject {
    private let wordbookService = WordbookService()
    @Published var wordbook: Wordbook
    
    @Published var editMode = EditMode.inactive
    @Published var isAddShown = false
    @Published var isDetailsShown = false {
        willSet {
            if newValue == false {
//                wordbook = wordbooksService.getSameWordbook(current: wordbook)
            }
        }
    }
    @Published var cardViewShown = false
    @Published var wordbookIndex = 0
    
    init(wordbook: Wordbook) {
        self.wordbook = wordbook
    }
}
