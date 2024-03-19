//
//  TestModeView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/8/23.
//

import SwiftUI
import SwiftUIPager

struct TestModeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject private var controller: WordsController
    @StateObject private var testCardController = TestCardController()
    @StateObject private var page: Page = .first()
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                Pager(page: page,
                      data: controller.wordbook.words,
                      id: \.id) { word in
                    TestCardItem(word: word, isImageShown: $testCardController.isImagesShown, geo: geo)
                }
                      .allowsDragging(false)
                      .preferredItemSize(CGSize(width: geo.size.width - 70, height: .infinity))
                      .itemSpacing(8)
                      .interactive(scale: 0.8)
                      .interactive(rotation: true)
                      .edgesIgnoringSafeArea(.all)
                      .background(Color(.systemGroupedBackground))
            }
            
            HStack(alignment: .center, spacing: 15) {
                Spacer()
                
                Menu {
                    Toggle(isOn: $testCardController.isImagesShown) {
                        Label("alwaysShowImages", systemImage: "photo")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundStyle(Color(.secondaryLabel))
                        .imageScale(.large)
                }

                DismissButton(dismiss, colorScheme, action: {
                    testCardController.isDismissAlertShown.toggle()
                })
                    .padding(.trailing)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 10)
            
            HStack {
                Spacer()
                Text("\(page.index + 1) / \(controller.wordbook.words.count)")
                    .foregroundStyle(Color(.secondaryLabel))
                    .padding()
                Spacer()
            }
            
            ZStack(alignment: .center) {
                if testCardController.isMissedShown {
                    Rectangle()
                        .fill(Color(.systemGray6).opacity(0.4))
                        .ignoresSafeArea()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    MissedOverlay
                        .transition(.scale)
                }
            }
        }
        .environmentObject(page)
        .environmentObject(testCardController)
        .animation(.bouncy, value: testCardController.isMissedShown)
        .toolbar(.hidden, for: .navigationBar)
        .alert("warning", isPresented: $testCardController.isDismissAlertShown) {
            Button("yes", role: .destructive) {
                testCardController.isDismissAlertShown.toggle()
                dismiss()
            }
            Button("no", role: .cancel) {
                testCardController.isDismissAlertShown.toggle()
            }
        } message: {
            Text("testDismissAlert")
        }
    }
    
    private var MissedOverlay: some View {
        VStack(spacing: 15) {
            Image(systemName: "xmark")
                .font(.system(size: 64))
                .bold()
                .foregroundStyle(.red.opacity(0.8))
                .padding()
            
            Text("missedLabel")
                .padding(.bottom)
            
            HStack(alignment: .top, spacing: 15) {
                Button {
                    withAnimation {
                        testCardController.isMissedShown.toggle()
                    }
                } label: {
                    Text("undo")
                        .foregroundStyle(Color(.label))
                        .padding(.vertical, 12)
                        .frame(minWidth: 80, maxWidth: 150)
                }
                .background(Color(.systemGray4))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 10, y: 2)
                
                Button {
                    controller.incrementMissedCount(for: page.index)
                    withAnimation {
                        testCardController.isMissedShown.toggle()
                    }
                    withAnimation {
                        page.update(.next)
                    }
                } label: {
                    Text("next")
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(minWidth: 80, maxWidth: 150)
                }
                .background(.blue)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 10, y: 2)
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 15, y: 4)
        .padding()
    }
}
