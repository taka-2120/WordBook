//
//  WordbooksController.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

class WordbooksController: ObservableObject {
    private let wordbookService = WordbookService()
    @Published var wordbooks: [Wordbook] = []
    
    @Published var isAddShown = false {
        willSet {
            if newValue == false {
                getWordbooks()
            }
        }
    }
    @Published var isSettingsShown = false
    
    init() {
        getWordbooks()
    }
    
    func getWordbooks() {
        self.wordbooks = wordbookService.getWordbooks()
    }
    
    func pinWordbook() {
        
    }
    
    func removeWordbook(at index: Int) {
        Task { @MainActor in
            let cache = wordbooks[index]
            do {
                wordbooks.remove(at: index)
                try await wordbookService.removeWordbook(at: index)
                getWordbooks()
            } catch {
                print(error)
                wordbooks.insert(cache, at: index)
            }
        }
    }
}
