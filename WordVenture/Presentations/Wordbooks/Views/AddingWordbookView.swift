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
                
//                Divider()
//                    .padding(8)
//
//                Text("Language")
//                    .font(.title3)
//                    .fontWeight(.bold)
//                
//                HStack {
//                    Picker("", selection: $controller.originalLanguage) {
//                        ForEach(controller.languages, id: \.self) { language in
//                            Text(controller.getLanguageName(for: language))
//                                .tag(language)
//                        }
//                    }
//                    .pickerStyle(.automatic)
//                    .padding(4)
//                    .background(.regularMaterial)
//                    .cornerRadius(15)
//                    
//                    Image(systemName: "arrow.right")
//                        .font(.title2)
//                    
//                    Picker("", selection: $controller.translatedLanguage) {
//                        ForEach(controller.languages, id: \.self) { language in
//                            Text(controller.getLanguageName(for: language))
//                                .tag(language)
//                        }
//                    }
//                    .pickerStyle(.automatic)
//                    .padding(4)
//                    .background(.regularMaterial)
//                    .cornerRadius(15)
//                }
                
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
            .alert(L10n.error.rawValue, isPresented: $controller.isErrorShown) {
                Text(L10n.ok.rawValue)
            } message: {
                Text(controller.errorMessage)
            }
            .loading($controller.isLoading)
        }
    }
}
