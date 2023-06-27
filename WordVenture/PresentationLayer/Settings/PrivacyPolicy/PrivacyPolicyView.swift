//
//  PrivacyPolicyView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI
import MarkdownUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var markdownText = "" {
        willSet {
            if newValue != "" {
                isLoading = false
            }
        }
    }
    @State private var isLoading = true
    
    private let date: Date?
    private let needPadding: Bool
    private let selfNavigatable: Bool
    
    init(date: Date? = nil, needPadding: Bool = false, selfNavigatable: Bool = false) {
        self.date = date
        self.needPadding = needPadding
        self.selfNavigatable = selfNavigatable
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                ScrollView {
                    if let date = date {
                        VStack(alignment: .leading) {
                            Text("updated \(DocKind.privacyPolicy.key.toString()) \(date.formatted(date: .complete, time: .standard))")
                                .multilineTextAlignment(.leading)
                            Divider()
                        }
                        .padding([.bottom, .horizontal])
                    }
                    
                    Markdown(markdownText)
                        .markdownTheme(.gitHub)
                        .background(Color(.systemGroupedBackground))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom, needPadding ? 150 : 15)
                        .padding(.top, 30)
                }
            }
            
            if selfNavigatable {
                HStack {
                    Spacer()
                    DismissButton(dismiss, colorScheme)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut, value: markdownText)
        .task {
            markdownText = await SharedFile.privacyPolicy.fetchFileData()
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
