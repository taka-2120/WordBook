//
//  EditingView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct EditingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var originalWord: String
    var translatedWord: String
    var priority: Int
    var missed: Int
    var wordId: UUID
    @Binding var wordbookIndex: Int
    @Binding var wordbooks: [Wordbooks]
    @Binding var words: [Words]
    
    @State var originalWord_in = ""
    @State var translatedWord_in = ""
    @State var priority_in = 0
    @State var missed_in = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Original Word", text: $originalWord_in)
                    TextField("Translated Word", text: $translatedWord_in)
                }
                
                Section {
                    HStack {
                        Text("Missed")
                        Spacer()
                        Text(String(missed))
                    }
                }
                
                Section {
                    HStack {
                        Text("Priority")
                        Spacer()
                        Text(priorityDetector().priority)
                            .foregroundColor(priorityDetector().foreground)
                    }
                    Picker(selection: $priority_in, label: Text("")) {
                        Text("None").tag(0)
                        Text("Low").tag(1)
                        Text("Mid").tag(2)
                        Text("High").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Edit"))
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
                    .fontWeight(.regular)
            }), trailing: Button(action: {
                let index = wordIndexDetector(words: words, id: wordId)
                wordbooks[wordbookIndex].words[index].originalWord = originalWord_in
                wordbooks[wordbookIndex].words[index].translatedWord = translatedWord_in
                wordbooks[wordbookIndex].words[index].priority = priority_in
                words[index].originalWord = originalWord_in
                words[index].translatedWord = translatedWord_in
                words[index].priority = priority_in
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            }))
            .onAppear() {
                originalWord_in = originalWord
                translatedWord_in = translatedWord
                priority_in = priority
                missed_in = missed
            }
        }
    }
    
    func priorityDetector() -> (priority: String, foreground: Color) {
        if priority_in == 1 {
            return ("Low", Color(.systemBlue))
        } else if priority_in == 2 {
            return ("Mid", Color(.systemOrange))
        } else if priority_in == 3 {
            return ("High", Color(.systemRed))
        } else {
            return ("None", Color(.label))
        }
    }
}


