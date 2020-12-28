//
//  AddingWordbookView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct AddingWordbookView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var wordsViewShown: Bool
    @Binding var wordbooks: [Wordbooks]
    @Binding var indexOfWordbook: Int
    
    @State var title = ""
    @State var error = false
    @State var empty = true
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("TITLE")) {
                    TextField("Type Title", text: $title)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Create New Wordbook"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .fontWeight(.regular)
                }), trailing: Button(action: {
                if title != "" {
                    for i in 0 ... wordbooks.count - 1 {
                        if wordbooks[i].name == title {
                            error = true
                            empty = false
                            return
                        }
                    }
                    wordbooks.append(Wordbooks(name: title, words: []))
                    for i in 0 ... wordbooks.count - 1 {
                        if wordbooks[i].name == title {
                            indexOfWordbook = i
                            wordsViewShown = true
                            presentationMode.wrappedValue.dismiss()
                            return
                        }
                    }
                } else {
                    error = true
                    empty = true
                }
            }, label: {
                Text("Create")
            })
            .alert(isPresented: $error, content: {
                Alert(title: Text("Error"), message: Text(empty ? "You can't empty the title." : "The wordbook named this title is aleady exists."), dismissButton: .destructive(Text("OK")))
            }))
        }
    }
}
