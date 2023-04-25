//
//  AddWordbookService.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

class AddWordbookController: ObservableObject {
    private let wordbooksService = WordbookService.shared
    
    @Published var title = ""
    @Published var color = Color.blue
    
    func addWordbook() {
        let newWordbook = Wordbook(userId: UUID(), name: title, color: color.toHex(), words: [], modifiedDate: Date().ISO8601Format())
        wordbooksService.addWordbook(newWordbook: newWordbook)
    }
}
