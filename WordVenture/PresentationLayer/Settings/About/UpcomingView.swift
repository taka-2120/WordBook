//
//  UpcomingView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import MarkdownUI

struct UpcomingView: View {
    var body: some View {
        ScrollView {
            Markdown(SharedFile.upcoming.getMarkdown())
                .markdownTheme(.gitHub)
                .background(Color(.systemGroupedBackground))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
