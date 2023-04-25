//
//  WordbooksController.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

class WordbooksController: ObservableObject {
    private let wordbooksService = WordbookService.shared
    @Published var wordbooks: [Wordbook] = []
    
    @Published var isAddShown = false {
        willSet {
            if newValue == false {
                fetchWordbook()
            }
        }
    }
    @Published var isSettingsShown = false
    
    init() {
        fetchWordbook()
    }
    
    func addWordbook(newWordbook: Wordbook) {
        wordbooksService.addWordbook(newWordbook: newWordbook)
    }
    
    func fetchWordbook() {
        wordbooks = wordbooksService.wordbooks
    }
}
