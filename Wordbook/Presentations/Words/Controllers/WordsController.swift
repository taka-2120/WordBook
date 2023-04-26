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
    @Published var isAddShown = false {
        willSet {
            if newValue == false && wordbookIndex != nil {
                wordbook = wordbookService.getWordbooks()[wordbookIndex!]
            }
        }
    }
    @Published var isDetailsShown = false {
        willSet {
            if newValue == false {
//                wordbook = wordbooksService.getSameWordbook(current: wordbook)
            }
        }
    }
    @Published var cardViewShown = false
    @Published var wordbookIndex: Int? = nil
    
    init(wordbook: Wordbook) {
        self.wordbook = wordbook
        self.wordbookIndex = wordbookService.getWordbooks().firstIndex(of: wordbook)
    }
}
