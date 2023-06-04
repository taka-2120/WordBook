//
//  CreditsView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//
// https://lottiefiles.com/24291-stack-of-books
// https://www.freepik.com/free-vector/mobile-login-concept-illustration_4957136.htm#&position=1&from_view=collections

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("credits")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            Text("[Launch image](https://lottiefiles.com/24291-stack-of-books) is created by Scott A on LottieFiles")
            Text("[Sign in](https://www.freepik.com/free-vector/mobile-login-concept-illustration_4957136.htm#&position=1&from_view=collections) and [sign up](https://www.freepik.com/free-vector/high-five-concept-illustration_7010860.htm#&position=0&from_view=collections) images are created by storyset on Freepik")
            
            Spacer()

        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
