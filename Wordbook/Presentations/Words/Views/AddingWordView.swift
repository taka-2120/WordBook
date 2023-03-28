//
//  AddingWordView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct AddingWordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var words: [Words]
    @Binding var wordbooks: [WordBooks]
    @Binding var wordbookIndex: Int
    @State var originalWord = ""
    @State var translatedWord = ""
    @State var error = false
    @State var words_in: [Words] = []
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Original")) {
                    TextField("Word", text: $originalWord)
                }
                
                Section(header: Text("Translated")) {
                    TextField("Word", text: $translatedWord)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Add New Word"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
                    .fontWeight(.regular)
            }), trailing: Button(action: {
                if originalWord == "" || translatedWord == "" {
                    error = true
                    return
                }
                words_in.append(Words(originalWord: originalWord, translatedWord: translatedWord, priority: 0, missed: 0))
                wordbooks[wordbookIndex].words = words_in
                words = words_in
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Add")
            }))
            .alert(isPresented: $error) {
                Alert(title: Text("Error"), message: Text("You can't empty the words."), dismissButton: .destructive(Text("OK")))
            }
            .onAppear() {
                words_in = words
            }
        }
    }
}
