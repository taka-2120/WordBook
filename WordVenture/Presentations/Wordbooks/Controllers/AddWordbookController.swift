//
//  AddWordbookServiceImpl.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

@MainActor
class AddWordbookController: LoadablePresenter {
    @StateObject var dialogManager = DialogManager()
    private let wordbookService = WordbookServiceImpl()
    
    @Published var title = ""
    @Published var color = Color.blue
    
    func addWordbook(_ dismiss: DismissAction) {
        loadingTask { [self] in
            do {
                _ = try await wordbookService.addWordbook(
                    name: title,
                    color: color.toHex(),
                    original: "",
                    translated: ""
                )
                dismiss()
            } catch {
                dialogManager.showErrorDialog(message: "\(error.localizedDescription)")
            }
        }
    }
}
