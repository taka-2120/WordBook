//
//  PrivacyPolicyView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI
import MarkdownUI

struct PrivacyPolicyView: View {
    @State private var markdownText = "" {
        willSet {
            if newValue != "" {
                isLoading = false
            }
        }
    }
    @State private var isLoading = true
    
    private let needPadding: Bool
    
    init(needPadding: Bool = false) {
        self.needPadding = needPadding
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                ScrollView {
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
            markdownText = await SharedFile.privacyPolicy.fetchFileData()
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
