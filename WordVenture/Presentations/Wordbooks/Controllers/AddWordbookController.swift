//
//  AddWordbookService.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

class AddWordbookController: ObservableObject {
    private let wordbookService = WordbookService()
    
    @Published var title = ""
    @Published var color = Color.blue
    @Published var isLoading = false
    
    let languages = NSLocale.isoLanguageCodes.sorted()
    let currentLanguage = NSLocale.current.language.languageCode?.identifier ?? "en"
    @Published var originalLanguage = ""
    @Published var translatedLanguage = "en"
    
    init() {
        originalLanguage = currentLanguage
    }
    
    func addWordbook(_ dismiss: DismissAction) {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await wordbookService.addWordbook(name: title, color: color.toHex(), original: originalLanguage, translated: translatedLanguage)
                dismiss()
            } catch {
                print(error)
            }
        }
    }
    
    func getLanguageName(for language: String) -> String {
        let locale = NSLocale(localeIdentifier: currentLanguage)
        let name = locale.displayName(forKey: .languageCode, value: language) ?? ""
        return name
    }
}
