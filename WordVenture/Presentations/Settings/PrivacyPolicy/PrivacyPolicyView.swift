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
            Text("privacyPolicy")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            ScrollView {
                VStack {
                    Text("Our Privacy Policy Here...")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
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
