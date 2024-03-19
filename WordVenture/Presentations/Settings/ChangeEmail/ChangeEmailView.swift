//
//  ChangeEmailView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller = ChangeEmailController()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("currentEmail") +
            Text(controller.email)
                .bold()
            
            CustomField("newEmail", isEmail: true, text: $controller.newEmail)
            
            CustomField("password", isSecured: true, text: $controller.password)
            
            Spacer()
            
            Button {
                controller.updateEmailConfirmation()
            } label: {
                Text("update")
                    .foregroundColor(Color(.systemBackground))
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: 250)
            }
            .background(Color(.label))
            .cornerRadius(15)
        }
        .padding()
        .navigationTitle("changeEmail")
        .navigationBarTitleDisplayMode(.inline)
        .alert("confirmation", isPresented: $controller.isEmailConfirmationPromptShown) {
            Button(role: .destructive) {
                controller.updateEmail(dismiss)
            } label: {
                Text("OK")
            }
        } message: {
            Text("emailConfirmation")
        }
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
        .loading($controller.isLoading)
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
