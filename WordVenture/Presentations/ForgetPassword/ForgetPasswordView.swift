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
                Text(L10n.resetNote.rawValue)
                    .frame(alignment: .leading)
                
                Group {
                    Text(L10n.resetEmailNote.rawValue) +
                    Text(controller.email)
                        .fontWeight(.bold)
                }
                .multilineTextAlignment(.center)
                .padding(.vertical)
                
                Spacer()
                
                Button {
                    controller.sendResetEmail()
                } label: {
                    Text(L10n.sendEmail.rawValue)
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
            .navigationTitle(L10n.forgetPassword.rawValue)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    DismissButton(dismiss, colorScheme)
                }
            }
            .alert(L10n.error.rawValue, isPresented: $controller.isErrorShown) {
                Text(L10n.ok.rawValue)
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
