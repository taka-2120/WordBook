//
//  AddingWordbookView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct AddWordbookView: View {
    @StateObject private var controller = AddWordbookController()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                CustomField(L10n.title.rawValue, text: $controller.title)
                
                Divider()
                    .padding(8)
                
                ColorPicker(L10n.color.rawValue, selection: $controller.color, supportsOpacity: false)
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text(L10n.newWordbook.rawValue), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text(L10n.cancel.rawValue)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        controller.addWordbook(dismiss)
                    } label: {
                        Text(L10n.add.rawValue)
                            .bold()
                    }
                    .disabled(controller.title.isEmpty)
                }
            }
            .dialog(manager: controller.dialogManager)
            .loading($controller.isLoading)
        }
    }
}
