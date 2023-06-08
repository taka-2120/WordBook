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
                CustomField("title", text: $controller.title)
                
                Divider()
                    .padding(8)
                
                ColorPicker("color", selection: $controller.color, supportsOpacity: false)
                
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
            .navigationBarTitle(Text("newWordbook"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        controller.addWordbook(dismiss)
                    } label: {
                        Text("add")
                            .bold()
                    }
                    .disabled(controller.title.isEmpty)
                }
            }
            .alert("error", isPresented: $controller.isErrorShown) {
                Text("OK")
            } message: {
                Text(controller.errorMessage)
            }
            .loading($controller.isLoading)
        }
    }
}
