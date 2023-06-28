//
//  ForgetPasswordView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/24/23.
//

import SwiftUI

struct ForgetPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var controller = ForgetPasswordController()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("resetNote")
                    .frame(alignment: .leading)
                
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
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .navigationTitle("forgetPassword")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    DismissButton(dismiss, colorScheme)
                }
            }
            .alert("error", isPresented: $controller.isErrorShown) {
                Text("OK")
            } message: {
                Text(controller.errorMessage)
            }
            .loading($controller.isLoading)
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
