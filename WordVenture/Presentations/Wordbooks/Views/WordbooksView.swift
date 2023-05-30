//
//  ContentView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/09/30.
//

import SwiftUI
import SwipeActions

struct WordbooksView: View {
    @ObservedObject private var controller = WordbooksController()
    @State private var wordbookPathes = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $wordbookPathes) {
            Group {
                
                if controller.wordbooks.isEmpty {
                    VStack {
                        Spacer()
                        Image(systemName: "square.stack.3d.up.slash")
                            .symbolRenderingMode(.hierarchical)
                            .font(.system(size: 64))
                            .padding()
                        Text("noWordbooks")
                            .font(.title3)
                            .bold()
                        Spacer()
                        
                        GADNativeViewControllerWrapper()
                            .frame(height: 100)
                            .background(Color(.systemFill))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.15), radius: 15, y: 4)
                            .padding(18)
                    }
                } else {
                    ScrollView {
                        SwipeViewGroup {
                            ForEach(Array(controller.wordbooks.enumerated()), id: \.offset) { index, wordbook in
                                WordbookItem(wordbook: wordbook, index: index)
                            }
                        }
                        
                        GADNativeViewControllerWrapper()
                            .frame(height: 100)
                            .background(Color(.systemFill))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.15), radius: 15, y: 4)
                            .padding(18)
                    }
                }
            }
            .navigationTitle("wordbooks")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Wordbook.self) { wordbook in
                WordsView(wordbook: wordbook)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        controller.isSettingsShown.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        controller.isAddShown.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $controller.isAddShown, content: { AddWordbookView() })
            .sheet(isPresented: $controller.isSettingsShown, content: { SettingsView() })
            .onChange(of: wordbookPathes) { newValue in
                if newValue.isEmpty {
                    controller.getWordbooks()
                }
            }
            .animation(.easeInOut, value: controller.wordbooks)
            .animation(.easeInOut, value: controller.wordbooks.isEmpty)
        }
        .environmentObject(controller)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordbooksView()
    }
}
