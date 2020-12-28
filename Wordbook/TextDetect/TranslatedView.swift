//
//  TranslatedView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/11/15.
//

import SwiftUI

struct TranslatedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expantionDetector = ExpantionDetector()
    let languages: [LanguageCodes] = [LanguageCodes(name: "English", code: "en-US", tag: 0),
                                      LanguageCodes(name: "French", code: "fr-FR", tag: 1),
                                      LanguageCodes(name: "Italian", code: "it-IT", tag: 2),
                                      LanguageCodes(name: "German", code: "de-DE", tag: 3),
                                      LanguageCodes(name: "Spanish", code: "es-ES", tag: 4),
                                      LanguageCodes(name: "Portuguese(Brazil)", code: "pt-BR", tag: 5),
                                      LanguageCodes(name: "Chinese(Simplified)", code: "zh-Hans", tag: 6),
                                      LanguageCodes(name: "Chinese(Traditional)", code: "zh-Hant", tag: 7)]
    @Binding var originalWord: String
    @Binding var originalWords: [String]
    @Binding var wordbooks: [Wordbooks]
    @Binding var words: [Words]
    @Binding var wordbookIndex: Int
    var single: Bool
    @State var selectedLanguage = 0
    @State var imagePickerIsShown = false
    @State var camaraIsShown = false
    @State var detectorIsShown = false
    @State var continuing = true
    @State var translatedWord = ""
    @State var error = false
    let closeNotif = NotificationCenter.default.publisher(for: .init(rawValue: "closeNotif"))
    
    var body: some View {
        VStack {
            VStack {
                DisclosureGroup("Text", isExpanded: $expantionDetector.byText) {
                    ZStack {
                        TextField("Type here...", text: $translatedWord)
                            .padding()
                    }
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(7)
                    .padding()
                    HStack {
                        Button(action: {
                            if originalWord == "" || translatedWord == "" {
                                error = true
                                return
                            }
                            words.append(Words(originalWord: originalWord, translatedWord: translatedWord, priority: 0, missed: 0))
                            wordbooks[wordbookIndex].words = words
                            NotificationCenter.default.post(name: .init(rawValue: "closeNotif"), object: nil)
                        }, label: {
                            Text("Add")
                        })
                        .padding()
                        .foregroundColor(.white)
                    }
                    .frame(maxWidth: 300)
                    .font(.system(size: 14))
                    .background(Color(.systemBlue))
                    .cornerRadius(7)
                    .padding()
                }
                DisclosureGroup("Photo", isExpanded: $expantionDetector.byPhoto) {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Translate from...")
                                .font(.title3)
                                .foregroundColor(Color(.secondaryLabel))
                                .padding([.leading, .bottom])
                            Picker(selection: $selectedLanguage, label: Text("")) {
                                ForEach(languages, id: \.id) { language in
                                    Text(language.name).tag(language.tag)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        .padding()
                        
                        Button(action: {
                            camaraIsShown = true
                            imagePickerIsShown = true
                        }, label: {
                            HStack {
                                Image(systemName: "camera")
                                Text("Take a Photo")
                            }
                            .foregroundColor(Color(.label))
                            .padding()
                        })
                        .frame(maxWidth: 300)
                        .font(.system(size: 14))
                        .background(Color(.systemBlue))
                        .cornerRadius(7)
                        .padding()
                        
                        Button(action: {
                            camaraIsShown = false
                            imagePickerIsShown = true
                        }, label: {
                            HStack {
                                Image(systemName: "photo")
                                Text("Import from Library")
                            }
                            .foregroundColor(Color(.label))
                            .padding()
                        })
                        .frame(maxWidth: 300)
                        .font(.system(size: 14))
                        .background(Color(.systemBlue))
                        .cornerRadius(7)
                        .padding()
                    }
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $error) {
                Alert(title: Text("Error"), message: Text("You can't empty the words."), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarTitle(originalWord)
    }
}
