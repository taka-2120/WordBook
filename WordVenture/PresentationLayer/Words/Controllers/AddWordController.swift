//
//  AddWordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

@MainActor class AddWordController: WordController, Sendable {
    
    func addWord(_ dismissAction: @escaping () -> Void) {
        isLoading = true
        
        Task {
            defer {
                isLoading = false
            }
            
            do {
                try await wordbookService.addWord(original: originalWord, translated: translatedWord,
                                                  priority: 0, missed: 0, thumbnailUrl: "", imageUrls: imageUrls,
                                                  synonyms: synonyms, antonyms: antonyms, examples: examples,
                                                  imageSearchCount: imageSearchCount, textGeneratedCount: textGeneratedCount, to: wordbook)
                dismissAction()
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
}
