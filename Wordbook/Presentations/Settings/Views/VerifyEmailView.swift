//
//  VerifyEmailView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/30/23.
//

import SwiftUI

struct VerifyEmailView: View {
    
    @ObservedObject private var controller = SettingsController()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Verify Email")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            Text("We'll send a verification email to \(controller.email).")
            
            Spacer()
            
            Button {
//                controller.verifyEmail()
            } label: {
                Text("Send")
                    .foregroundColor(Color(.systemBackground))
                    .font(.title3)
                    .padding()
            }
            .frame(maxWidth: 250)
            .background(Color(.label))
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
