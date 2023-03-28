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
    @Binding var wordbooks: [WordBooks]
    @Binding var indexOfWordbook: Int
    
    @State var title = ""
    @State var error = false
    @State var empty = true
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.bold)
                })
                Spacer()
                Text("Create New WordBook")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    if title != "" {
                        for i in 0 ... wordbooks.count - 1 {
                            if wordbooks[i].name == title {
                                error = true
                                empty = false
                                return
                            }
                        }
                        wordbooks.append(WordBooks(name: title, words: [], modifiedDate: Date()))
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
                    Image(systemName: "checkmark")
                        .font(.title2)
                        .fontWeight(.bold)
                })
            }
            
            TextField("Enter Title...", text: $title)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.top, 50)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .alert(isPresented: $error, content: {
            Alert(title: Text("Error"), message: Text(empty ? "You can't empty the title." : "The wordbook named this title is aleady exists."), dismissButton: .destructive(Text("OK")))
        })
    }
}
