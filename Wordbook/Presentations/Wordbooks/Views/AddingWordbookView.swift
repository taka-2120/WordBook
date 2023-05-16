//
//  AddingWordbookView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct AddWordbookView: View {
    @ObservedObject private var controller = AddWordbookController()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                CustomField("Title", text: $controller.title)
                
                ColorPicker("Color", selection: $controller.color, supportsOpacity: false)
                
                Spacer()
            }
            .loading($controller.isLoading)
            .padding()
            .navigationBarTitle(Text("New Wordbook"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        controller.addWordbook(dismiss)
                    } label: {
                        Image(systemName: "checkmark")
                            .bold()
                    }
                    .disabled(controller.title.isEmpty)
                }
            }
        }
    }
}
