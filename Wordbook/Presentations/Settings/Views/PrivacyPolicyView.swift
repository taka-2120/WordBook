//
//  PrivacyPolicyView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Privacy Policy")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            ScrollView {
                Text("Our Privacy Policy Here...")
            }

        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
