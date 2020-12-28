//
//  ContentView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/09/30.
//

import SwiftUI

struct Wordbooks {
    var id = UUID()
    var name: String
    var words: [Words]
}

struct Words: Equatable, Identifiable {
    var id = UUID()
    var originalWord: String
    var translatedWord: String
    var priority: Int
    var missed: Int
}

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var editMode = EditMode.inactive
    @State var words: [Words] = []
    @State var wordbooks: [Wordbooks] = []
    
    @State var addViewShown = false
    @State var wordsViewShown = false
    @State var indexOfWordbook = 0
    @State var isNavBarHidden = false
    @State var infoView = false
    
    @State var first = true
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                if wordbooks.count != 0 {
                    NavigationLink("", destination: WordsView(wordbooks: $wordbooks, isNavBarHidden: $isNavBarHidden, wordbookId: wordbooks[indexOfWordbook].id), isActive: $wordsViewShown)
                }
                
                VStack(spacing: 0) {
                    List {
                        //Dashboard
                        Section {
                            VStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(LinearGradient(gradient: Gradient(colors: [hexColor(0x639CFF), hexColor(0x4FB0FF)]), startPoint: .leading, endPoint: .topTrailing))
                                                .frame(maxWidth: 80, maxHeight: 80)
                                                .shadow(radius: 10)
                                            VStack {
                                                Text("14")
                                                    .foregroundColor(Color.white)
                                                    .font(.system(size: 32, design: .rounded))
                                                    .fontWeight(.bold)
                                            }
                                        }
                                        Text("Words")
                                            .foregroundColor(Color(.secondaryLabel))
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                    }
                                    Spacer()
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(LinearGradient(gradient: Gradient(colors: [hexColor(0xFF9063), hexColor(0xFFAA4F)]), startPoint: .leading, endPoint: .topTrailing))
                                                .frame(maxWidth: 80, maxHeight: 80)
                                                .shadow(radius: 10)
                                            Text("30")
                                                .foregroundColor(Color.white)
                                                .font(.system(size: 32, design: .rounded))
                                                .fontWeight(.bold)
                                        }
                                        Text("Mins")
                                            .foregroundColor(Color(.secondaryLabel))
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                    }
                                    Spacer()
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(LinearGradient(gradient: Gradient(colors: [hexColor(0xFF64B6), hexColor(0xFF5082)]), startPoint: .leading, endPoint: .topTrailing))
                                                .frame(maxWidth: 80, maxHeight: 80)
                                                .shadow(radius: 10)
                                            Text("0")
                                                .foregroundColor(Color.white)
                                                .font(.system(size: 32, design: .rounded))
                                                .fontWeight(.bold)
                                        }
                                        Text("Missed")
                                            .foregroundColor(Color(.secondaryLabel))
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                    }
                                    Spacer()
                                }
                            }
                            .frame(minHeight: 130)
                        }
                        
                        //Wordbooks
                        ForEach(wordbooks, id: \.id) { wordbook in
                            NavigationLink(wordbook.name, destination: WordsView(wordbooks: $wordbooks, isNavBarHidden: $isNavBarHidden, wordbookId: wordbook.id))
                        }
                        .onMove(perform: { indices, newOffset in
                            wordbooks.move(fromOffsets: indices, toOffset: newOffset)
                        })
                        .onDelete(perform: { indexSet in
                            wordbooks.remove(atOffsets: indexSet)
                        })
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationBarTitle(Text("Wordbooks"))
                    .navigationBarItems(leading: HStack {
                        Button(action: {
                            infoView = true
                        }, label: {
                            Image(systemName: "info.circle")
                        })
                        .foregroundColor(Color(.label))
                        .font(.system(size: 20))
                        .padding(.trailing, 10)
                        .sheet(isPresented: $infoView) {
                            InfoView()
                        }
                        
                        Button(action: { addViewShown = true }, label: {
                            Image(systemName: "plus")
                        })
                        .foregroundColor(Color(.label))
                    } , trailing: EditButton().foregroundColor(Color(.label)))
                    .environment(\.editMode, $editMode)
                }
            }
            .navigationBarHidden(isNavBarHidden)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(Color(.systemGroupedBackground))
        .onAppear() {
            if first == true {
                words.append(Words(originalWord: "Hello", translatedWord: "こんにちは", priority: 1, missed: 0))
                words.append(Words(originalWord: "Good", translatedWord: "良い", priority: 0, missed: 0))
                words.append(Words(originalWord: "Good", translatedWord: "良い", priority: 0, missed: 0))

                wordbooks.append(Wordbooks(name: "System English Words", words: words))
                first = false
            }
        }
        .sheet(isPresented: $addViewShown) {
            AddingWordbookView(wordsViewShown: $wordsViewShown, wordbooks: $wordbooks, indexOfWordbook: $indexOfWordbook)
        }
    }
}

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Version")
                        .font(.body)
                        .fontWeight(.regular)
                    Spacer()
                    Text("1.0.0 Pre")
                        .font(.body)
                        .fontWeight(.regular)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Information")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Close")
                    .font(.body)
                    .fontWeight(.regular)
            }))
        }
    }
}

func wordIndexDetector(words: [Words], id: UUID) -> Int {
    for i in 0 ... words.count - 1 {
        if words[i].id == id {
            return i
        }
    }
    return words.count
}

fileprivate struct HiddenModifier: ViewModifier {

    private let isHidden: Bool
    private let remove: Bool

    init(isHidden: Bool, remove: Bool) {
        self.isHidden = isHidden
        self.remove = remove
    }

    func body(content: Content) -> some View {
        VStack {
            if isHidden == true {
                if remove == true {
                    EmptyView()
                } else {
                    content.hidden()
                }
            } else {
                content
            }
        }
    }
}

extension View {
    func isHidden(_ hidden: Bool, remove: Bool) -> some View {
        modifier(HiddenModifier(isHidden: hidden, remove: remove))
    }
}

//Code
prefix operator ⋮
prefix func ⋮(hex:UInt32) -> Color {
    return Color(hex)
}

extension Color {
    init(_ hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

let hexColor:(UInt32) -> (Color) = {
    return Color($0)
}
