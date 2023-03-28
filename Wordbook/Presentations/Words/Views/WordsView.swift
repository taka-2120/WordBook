//
//  WordsView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI
import VisionKit
import Vision

struct WordsView: View {
    
    @Binding var wordbooks: [WordBooks]
    @Binding var isNavBarHidden: Bool
    var wordbookId: UUID
    
    @Environment(\.presentationMode) var presentationMode
    @State var editMode = EditMode.inactive
    @State var addViewShown = false
    @State var cardViewShown = false
    @State var editingViewShown = false
    @State var words: [Words] = []
    @State var wordbookIndex = 0
    @State var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State var shown = false
    @State var detectorIsShown = false
    
    var body: some View {
        ZStack(alignment: .top) {
            NavigationLink("", destination: CardMode(wordbooks: $wordbooks, wordbookIndex: $wordbookIndex, words: $words, isNavBarHidden: $isNavBarHidden), isActive: $cardViewShown)
                .hidden()
            
            ScrollView {
                ForEach(words, id: \.id) { word in
                    WordItem(word: word, wordbookIndex: wordbookIndex, words: $words, wordbooks: $wordbooks)
                }
                .padding(.top, 20)
            }
            .padding(.top, 90)
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.title2)
                            .foregroundColor(Color(.label))
                    })
                    Spacer()
                    Text(wordbooks[wordbookIndex].name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        if words.count != 0 {
                            shown = true
                            isNavBarHidden = true
                            cardViewShown = true
                        }
                    }, label: {
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.title2)
                            .foregroundColor(Color(.label))
                    })
                }
                .padding()
                
                
                Text("\(words.count) Word\(countWord())")
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    CircleNavigationButton(
                        isShown: $detectorIsShown,
                        icon: "plus",
                        detents: [.large],
                        destination: AnyView(ImportMethodView(wordbooks: $wordbooks, words: $words, wordbookIndex: $wordbookIndex))
                    )
                }
            }
            .padding()
        }
        .background(Color(defaultBackground))
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            if shown == false {
                for i in 0 ... wordbooks.count - 1 {
                    if wordbooks[i].id == wordbookId {
                        words = wordbooks[i].words
                        wordbookIndex = i
                    }
                }
            }
        }
    }
    
    func countWord() -> String {
        if words.count == 1 {
            return ""
        } else {
            return "s"
        }
    }
}



struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        WordsView(wordbooks: .constant([WordBooks(name: "System English Words", words: [], modifiedDate: Date())]), isNavBarHidden: .constant(false), wordbookId: UUID())
    }
}
