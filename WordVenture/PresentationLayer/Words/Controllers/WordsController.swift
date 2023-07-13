//
//  WordsController.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import SwiftUI

@MainActor class WordsController: ObservableObject, Sendable {
    private let wordbookService = WordbookService()
    private let purchaseManager = PurchaseManager.shared
    
    @Published var wordbook: Wordbook
    @Published var selectedWord: Word? = nil
    
    @Published var editMode = EditMode.inactive
    @Published var isAddShown = false {
        willSet {
            if newValue == false {
                fetchWordbook()
            }
        }
    }
    @Published var isDetailsShown = false {
        willSet {
            if newValue == false {
                fetchWordbook()
            }
        }
    }
    @Published var isTestShown = false {
        willSet {
            fetchWordbook()
        }
    }
    @Published var isFlashCardShown = false {
        willSet {
            fetchWordbook()
        }
    }
    @Published var wordbookIndex: Int
    @Published var testAttempts: Int
    @Published var wordbookTitle = ""
    @Published var wordbookColor = Color.blue {
        willSet {
            updateWordbook()
        }
    }
    @Published var isPlanViewShown = false
    @Published var isMissedCountChecked: Bool
    @Published var isPriorityChecked: Bool
    @Published var hasUnlimited: Bool
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(wordbook: Wordbook, index: Int) {
        self.wordbook = wordbook
        self.wordbookIndex = index
        self.wordbookTitle = wordbook.name
        self.wordbookColor = Color(hex: wordbook.color)
        self.testAttempts = wordbook.testAttempts
        self.isPriorityChecked = UserDefaults.standard.value(forKey: showPriorityKey) as? Bool ?? true
        self.isMissedCountChecked = UserDefaults.standard.value(forKey: showMissedCountKey) as? Bool ?? true
        
        // Plan Check
        self.hasUnlimited = purchaseManager.hasUnlimited
        
        fetchVisibilities()
    }
    
    private func fetchVisibilities() {
        Task {
            do {
                let userData = try await wordbookService.fetchVisibilities(for: wordbook.userId)
                isPriorityChecked = userData.showPriority
                isMissedCountChecked = userData.showMissedCount
                
                storeVisibilitiesToUserDefaults()
            } catch {
                print(error)
            }
        }
    }
    
    private func storeVisibilitiesToUserDefaults() {
        UserDefaults.standard.setValue(isPriorityChecked, forKey: showPriorityKey)
        UserDefaults.standard.setValue(isMissedCountChecked, forKey: showMissedCountKey)
    }
    
    func updateWordItemVisibilities() {
        Task {
            do {
                print(isPriorityChecked)
                try await wordbookService.updateVisibilities(
                    userId: wordbook.userId,
                    showPriority: isPriorityChecked,
                    showMissedCount: isMissedCountChecked)
            } catch {
                print(error)
            }
        }
    }
    
    // TODO: Handle Errors
    func updateWordbook() {
        Task {
            do {
                wordbook = try await wordbookService.updateWordbook(bookId: wordbook.bookId, name: wordbookTitle, color: wordbookColor.toHex(),
                                                                    original: nil, translated: nil, testAttempts: testAttempts)[wordbookIndex]
            } catch {
                print(error)
            }
        }
    }
    
    private func fetchWordbook() {
        Task {
            do {
                wordbook = try await wordbookService.fetchWordbook()[wordbookIndex]
            } catch {
                print(error)
            }
        }
    }
    
    func selectWord(for word: Word) {
        selectedWord = word
    }
    
    func removeWord(at index: Int) {
        Task {
            let word = wordbook.words[index]
            do {
                wordbook.words.remove(at: index)
                try await wordbookService.removeWord(for: wordbook, target: word.wordId)
                fetchWordbook()
            } catch {
                print(error)
                wordbook.words.insert(word, at: index)
            }
        }
    }
    
    func updatePriority(for word: Word, priority: Priority) {
        Task {
            do {
                try await wordbookService.updateWord(wordId: word.wordId, original: word.original, translated: word.translated,
                                                     priority: priority.index, missed: word.missed, correct: word.correct, thumbnailUrl: word.thumbnailUrl,
                                                     imageUrls: word.imageUrls, synonyms: word.synonyms, antonyms: word.antonyms, examples: word.examples,
                                                     imageSearchCount: word.imageSearchCount, textGeneratedCount: word.textGeneratedCount, to: wordbook)
            } catch {
                print(error)
            }
        }
    }
    
    func incrementCorrectCount(for index: Int) {
        Task {
            do {
                let word = wordbook.words[index]
                let newCorrectCount = word.missed + 1
                try await wordbookService.updateWord(wordId: word.wordId, original: word.original, translated: word.translated,
                                                     priority: word.priority, missed: word.missed, correct: newCorrectCount, thumbnailUrl: word.thumbnailUrl,
                                                     imageUrls: word.imageUrls, synonyms: word.synonyms, antonyms: word.antonyms, examples: word.examples,
                                                     imageSearchCount: word.imageSearchCount, textGeneratedCount: word.textGeneratedCount, to: wordbook)
            } catch {
                print(error)
            }
        }
    }
    
    func incrementMissedCount(for index: Int) {
        Task {
            do {
                let word = wordbook.words[index]
                let newMissedCount = word.missed + 1
                try await wordbookService.updateWord(wordId: word.wordId, original: word.original, translated: word.translated,
                                                     priority: word.priority, missed: newMissedCount, correct: word.correct, thumbnailUrl: word.thumbnailUrl,
                                                     imageUrls: word.imageUrls, synonyms: word.synonyms, antonyms: word.antonyms, examples: word.examples,
                                                     imageSearchCount: word.imageSearchCount, textGeneratedCount: word.textGeneratedCount, to: wordbook)
            } catch {
                print(error)
            }
        }
    }
}
