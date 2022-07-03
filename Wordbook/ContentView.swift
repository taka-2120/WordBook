//
//  ContentView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/09/30.
//

import SwiftUI
import Vision

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var editMode = EditMode.inactive
    @State var words: [Words] = []
    @State var wordbooks: [WordBooks] = []
    
    @State var isAddShown = false
    @State var isSettingsShown = false
    @State var wordsViewShown = false
    @State var indexOfWordbook = 0
    @State var isNavBarHidden = false
    
    @State var first = true
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {                
                ScrollView {
                    ForEach(wordbooks, id: \.id) { wordbook in
                        WordBookItem(name: wordbook.name, date: wordbook.modifiedDate.formatDateToString(showDate: true, showTime: false), isNavBarHidden: $isNavBarHidden, wordbooks: $wordbooks, selectedId: wordbook.id)
                    }
                    .padding(.top, 20)
                }
                .padding(.top, 170)
                
                VStack(spacing: 0) {
                    Text("WordBooks")
                        .font(.title)
                        .fontWeight(.bold)
                    Dashboard(wordCount: .constant(14), studied: .constant(30), missed: .constant(0))
                }
                .frame(maxWidth: .infinity)
                .background(Color(defaultBackground))
                .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                .shadow(color: Color(.systemGray5), radius: 5, y: 10)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        CircleNavigationButton(
                            isShown: $isSettingsShown,
                            icon: "gearshape.fill",
                            detents: [.large],
                            destination: AnyView(SettingsView())
                        )
                        Spacer()
                        CircleNavigationButton(
                            isShown: $isAddShown,
                            icon: "plus",
                            detents: [.medium],
                            destination: AnyView(AddingWordbookView(wordsViewShown: $wordsViewShown, wordbooks: $wordbooks, indexOfWordbook: $indexOfWordbook))
                        )
                    }
                }
                .padding()
            }
            .background(Color(defaultBackground))
            .onAppear() {
                print(try! VNRecognizeTextRequest().supportedRecognitionLanguages())
                if first == true {
                    words.append(Words(originalWord: "Hello", translatedWord: "こんにちは", priority: 1, missed: 0))
                    words.append(Words(originalWord: "Good", translatedWord: "良い", priority: 0, missed: 0))
                    words.append(Words(originalWord: "Good", translatedWord: "良い", priority: 0, missed: 0))

                    wordbooks.append(WordBooks(name: "System English Words", words: words, modifiedDate: Date()))
                    wordbooks.append(WordBooks(name: "System English Words", words: words, modifiedDate: Date()))
                    first = false
                }
            }
        }
        
        .toolbar(.hidden, in: .navigationBar)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
