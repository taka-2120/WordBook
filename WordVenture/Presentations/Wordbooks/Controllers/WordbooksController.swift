//
//  WordbooksController.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

@MainActor class WordbooksController: ObservableObject, Sendable {
    private let wordbookService = WordbookServiceImpl()
    private let iapService = IAPServiceImpl()
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
                Task { @MainActor in
                    self.hasUnlimited = await iapService.hasUnlimited()
                }
            }
        }
    }
    @Published var isPlanViewShown = false {
        willSet {
            if newValue == false {
                Task { @MainActor in
                    self.hasUnlimited = await iapService.hasUnlimited()
                }
            }
        }
    }
    @Published var hasUnlimited = false
    
    init() {
        self.fetchWordbooks()
        Task { @MainActor in
            self.hasUnlimited = await iapService.hasUnlimited()
        }
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
