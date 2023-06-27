//
//  ForgetPasswordView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/24/23.
//

import SwiftUI

struct ForgetPasswordView: View {
    @StateObject private var controller = ForgetPasswordController()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("resetNote")
                
                Group {
                    Text("resetEmailNote") +
                    Text(controller.email)
                        .fontWeight(.bold)
                }
                .multilineTextAlignment(.center)
                .padding(.vertical)
                
                Spacer()
                
                Button {
                    controller.sendResetEmail()
                } label: {
                    Text("sendEmail")
                        .foregroundColor(Color(.systemBackground))
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: 250)
                }
                .background(Color(.label))
                .cornerRadius(15)
            }
            .padding()
            .navigationTitle("forgetPassword")
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
