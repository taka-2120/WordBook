//
//  DeleteAccountView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/28/23.
//

import SwiftUI

struct DeleteAccountView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller = DeleteAccountController()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("deleteAccountDescription")
                .font(.callout)
                .foregroundColor(Color(.secondaryLabel))
                .multilineTextAlignment(.center)
            
            CustomField("email", isEmail: true, text: $controller.email)
            CustomField("password", isSecured: true, text: $controller.password)
            
            Spacer()
            
            Button {
                controller.confirmAccount()
            } label: {
                Text("delete")
                    .foregroundColor(Color(.systemBackground))
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: 250)
            }
            .background(Color(.label))
            .cornerRadius(15)

        }
        .padding()
        .navigationTitle("deleteAccount")
        .alert("deleteWarningTitle", isPresented: $controller.isDeleteWarningShown) {
            Button(role: .destructive) {
                controller.isDeleteFinalConfirmationShown = true
            } label: {
                Text("yes")
            }
            Button(role: .cancel) {
                controller.isDeleteFinalConfirmationShown = false
            } label: {
                Text("no")
            }
        } message: {
            Text("deleteWarningMessage")
        }
        .alert("deleteFinalConfirmationTitle", isPresented: $controller.isDeleteFinalConfirmationShown) {
            Button(role: .destructive) {
                controller.deleteAccount(dismiss)
            } label: {
                Text("delete")
            }
        } message: {
            Text("deleteFinalConfirmationMessage")
        }
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
        .loading($controller.isLoading)
    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}
