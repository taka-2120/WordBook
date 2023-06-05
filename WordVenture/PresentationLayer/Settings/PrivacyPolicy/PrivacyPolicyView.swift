//
//  PrivacyPolicyView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI
import MarkdownUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Markdown(SharedFile.privacyPolicy.getMarkdown())
                .markdownTheme(.gitHub)
                .background(Color(.systemGroupedBackground))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
