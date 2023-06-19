//
//  TermsAndConditionsView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/19/23.
//

import SwiftUI
import MarkdownUI

struct TermsAndConditionsView: View {
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
    
    init(date: Date? = nil, needPadding: Bool = false) {
        self.date = date
        self.needPadding = needPadding
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                ScrollView {
                    if let date = date {
                        VStack(alignment: .leading) {
                            Text("updated \(DocKind.termsAndConditions.key.toString()) \(date.formatted(date: .complete, time: .standard))")
                                .multilineTextAlignment(.leading)
                            Divider()
                        }
                        .padding()
                    }
                    
                    Markdown(markdownText)
                        .markdownTheme(.gitHub)
                        .background(Color(.systemGroupedBackground))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding([.horizontal, .top])
                        .padding(.bottom, needPadding ? 150 : 15)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut, value: markdownText)
        .task {
            markdownText = await SharedFile.termsAndConditions.fetchFileData()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    TermsAndConditionsView()
}
