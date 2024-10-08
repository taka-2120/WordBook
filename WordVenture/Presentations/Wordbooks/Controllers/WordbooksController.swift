//
//  WordbooksController.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

@MainActor class WordbooksController: ObservableObject, Sendable {
    private let wordbookService = WordbookService()
    private let purchaseManager = PurchaseManager.shared
    @Published var wordbooks: [Wordbook] = []
    
    @Published var isAddShown = false {
        willSet {
            if newValue == false {
                fetchWordbooks()
            }
        }
    }
    @Published var isSettingsShown = false {
        willSet {
            if newValue == false {
                self.hasUnlimited = purchaseManager.hasUnlimited
            }
        }
    }
    @Published var isPlanViewShown = false {
        willSet {
            if newValue == false {
                self.hasUnlimited = purchaseManager.hasUnlimited
            }
        }
    }
    @Published var hasUnlimited: Bool
    
    init() {
        // Plan Check
        self.hasUnlimited = purchaseManager.hasUnlimited
        
        self.fetchWordbooks()
    }
    
    func fetchWordbooks() {
        Task {
            do {
                wordbooks = try await wordbookService.fetchWordbook()
            } catch {
                print(error)
            }
        }
    }
    
    func pinWordbook() {
        
    }
    
    func isAdRemoved() -> Bool {
        return purchaseManager.hasUnlimited
    }
    
    func removeWordbook(at index: Int) {
        Task {
            let wordbook = wordbooks[index]
            do {
                wordbooks.remove(at: index)
                wordbooks = try await wordbookService.removeWordbook(target: wordbook.bookId)
            } catch {
                print(error)
                wordbooks.insert(wordbook, at: index)
            }
        }
    }
}
