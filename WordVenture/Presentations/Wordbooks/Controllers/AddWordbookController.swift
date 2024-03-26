//
//  AddWordbookServiceImpl.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

@MainActor class AddWordbookController: ObservableObject, Sendable {
    private let wordbookService = WordbookServiceImpl()
    
    let languages = NSLocale.isoLanguageCodes.sorted()
    let currentLanguage = NSLocale.current.language.languageCode?.identifier ?? "en"
    @Published var originalLanguage = ""
    @Published var translatedLanguage = "en"
    
    @Published var title = ""
    @Published var color = Color.blue
    @Published var isLoading = false
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init() {
        originalLanguage = currentLanguage
    }
    
    func addWordbook(_ dismiss: DismissAction) {
        isLoading = true
        
        Task {
            defer {
                isLoading = false
            }
            
            do {
                _ = try await wordbookService.addWordbook(name: title, color: color.toHex(), original: originalLanguage, translated: translatedLanguage)
                dismiss()
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
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
