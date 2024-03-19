//
//  UpcomingView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import MarkdownUI

struct UpcomingView: View {
    @State private var markdownText = "" {
        willSet {
            if newValue != "" {
                isLoading = false
            }
        }
    }
    @State private var isLoading = true
    
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
                        .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut, value: markdownText)
        .task {
            markdownText = await SharedFile.upcoming.fetchFileData()
        }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
