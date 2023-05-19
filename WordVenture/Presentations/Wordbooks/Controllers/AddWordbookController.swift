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
    
    func addWordbook(_ dismiss: DismissAction) {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await wordbookService.addWordbook(name: title, color: color.toHex())
                dismiss()
            } catch {
                print(error)
            }
        }
    }
}
