//
//  CreditsView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Credits")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            Text("Icons are provided by ...")
            Text("Images are provided by ...")
            
            Spacer()

        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
