//
//  AddWordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

class AddWordController: WordController {
    
    func addWord(_ dismiss: DismissAction) {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await wordbookService.addWord(original: originalWord, translated: translatedWord,
                                                  priority: 0, missed: 0, thumbnailUrl: "", imageUrls: imageUrls,
                                                  synonyms: synonyms, antonyms: antonyms, examples: examples,
                                                  imageSearchCount: imageSearchCount, textGeneratedCount: textGeneratedCount, to: wordbook)
                dismiss()
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
}
