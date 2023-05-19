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
            Text("Your current email is: ") +
            Text(controller.email)
                .bold()
            
            Text("Change Email")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            CustomField("New Email", isEmail: true, text: $controller.newEmail)
            
            CustomField("Password", isSecured: true, text: $controller.password)
            
            Spacer()
            
            Button {
                controller.updateEmailConfirmation()
            } label: {
                Text("Update")
                    .foregroundColor(Color(.systemBackground))
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: 250)
            }
            .background(Color(.label))
            .cornerRadius(15)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .alert("Confirmation", isPresented: $controller.isEmailConfirmationPromptShown) {
            Button(role: .destructive) {
                controller.updateEmail(dismiss)
            } label: {
                Text("OK")
            }
        } message: {
            Text("A confirmation email will be sent to your old address. Please check out the email and confirm it to finally update your email.")
        }
        .alert("Error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorType.rawValue)
        }
        .loading($controller.isLoading)
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
