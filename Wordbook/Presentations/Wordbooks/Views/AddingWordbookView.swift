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
                Text("Title")
                VStack(spacing: 0) {
                    TextField("Title", text: $controller.title)
                        .padding(.vertical)
                        .controlSize(.large)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .frame(height: 2)
                }
                
                ColorPicker("Color", selection: $controller.color, supportsOpacity: false)
                
                Spacer()
            }
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
