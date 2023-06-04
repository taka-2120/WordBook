//
//  WordbooksController.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

class WordbooksController: ObservableObject {
    private let purchaseManager = PurchaseManager.shared
    private let wordbookService = WordbookService()
    @Published var wordbooks: [Wordbook] = []
    
    @Published var isAddShown = false {
        willSet {
            if newValue == false {
                fetchWordbooks()
            }
        }
    }
    @Published var isSettingsShown = false
    
    init() {
        fetchWordbooks()
    }
    
    func fetchWordbooks() {
        Task { @MainActor in
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
        return purchaseManager.hasAdsRemoved || purchaseManager.hasUnlimited
    }
    
    func removeWordbook(at index: Int) {
        Task { @MainActor in
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
