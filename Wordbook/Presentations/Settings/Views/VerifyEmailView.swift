//
//  VerifyEmailView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/30/23.
//

import SwiftUI

struct VerifyEmailView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Verify Email")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            Text("We'll send a verification email to \("{address}").")
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Send")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
            }
            .frame(maxWidth: 250)
            .background(Color.black)
            .cornerRadius(15)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VerifyEmailView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailView()
    }
}
