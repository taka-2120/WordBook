//
//  ReleaseNotesView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import MarkdownUI

struct ReleaseNotesView: View {
    var body: some View {
        ScrollView {
            Markdown(SharedFile.releaseNotes.getMarkdown())
                .markdownTheme(.gitHub)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReleaseNotesView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseNotesView()
    }
}
