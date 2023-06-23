//
//  ContentView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/09/30.
//

import SwiftUI
import SwipeActions

struct WordbooksView: View {
    @StateObject private var controller = WordbooksController()
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
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                } else {
                    ScrollView {
                        SwipeViewGroup {
                            ForEach(Array(controller.wordbooks.enumerated()), id: \.offset) { index, wordbook in
                                WordbookItem(wordbook: wordbook, index: index)
                            }
                        }
                        .padding(.top)
                        
                        if !controller.hasUnlimited && controller.wordbooks.count == unlimitedMaxWordbookCount {
                            Divider()
                                .padding(10)
                            
                            Button {
                                controller.isPlanViewShown = true
                            } label: {
                                HStack {
                                    Text("needUnlimitedWordbook")
                                        .font(.headline)
                                        .foregroundColor(Color(.label))
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.horizontal)
                                .padding(.vertical, 20)
                                .background(.regularMaterial)
                                .cornerRadius(15)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .strokeBorder(.gray, style: StrokeStyle(lineWidth: 2, dash: [10]))
                                }
                            }
                            .padding()
                        }
                        
                        if !controller.hasUnlimited && controller.wordbooks.count < unlimitedMaxWordbookCount {
                            HStack {
                                Spacer()
                                Text("limit: \(controller.wordbooks.count)/\(unlimitedMaxWordbookCount)")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.callout)
                            }
                            .padding()
                        }
                    }
                }
            }
            .background(Color(.secondarySystemBackground))
            .navigationTitle("wordbooks")
            .navigationBarTitleDisplayMode(.large)
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
                    .disabled(!controller.hasUnlimited && controller.wordbooks.count == unlimitedMaxWordbookCount)
                    .opacity(!controller.hasUnlimited && controller.wordbooks.count == unlimitedMaxWordbookCount ? 0.6 : 1.0)
                }
            }
            .sheet(isPresented: $controller.isAddShown) {
                AddWordbookView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $controller.isSettingsShown, content: { SettingsView() })
            .sheet(isPresented: $controller.isPlanViewShown, content: { PlansView(selfNavigatable: true) })
            .animation(.easeInOut, value: controller.wordbooks)
            .animation(.easeInOut, value: controller.wordbooks.isEmpty)
            .onAppear {
                controller.fetchWordbooks()
            }
        }
        .environmentObject(controller)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordbooksView()
    }
}
