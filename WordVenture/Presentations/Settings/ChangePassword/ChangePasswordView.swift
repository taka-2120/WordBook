//
//  ChangePasswordView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller = ChangePasswordController()
    
    var body: some View {
        VStack(spacing: 15) {
            CustomField("oldPassword", keyType: .password, text: $controller.password)
            CustomField("newPassword", keyType: .password, text: $controller.newPassword)
            CustomField("reNewPassword", keyType: .password, text: $controller.reNewPassword)
            
            Text(LocalizedStringKey(stringLiteral: RegexType.passwordRegex.notes))
                .font(.callout)
                .foregroundStyle(Color(.secondaryLabel))
            
            Spacer()
            
            Button {
                controller.updatePassword(dismiss)
            } label: {
                Text("update")
                    .foregroundColor(Color(.systemBackground))
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: 250)
            }
            .background(Color(.label))
            .cornerRadius(15)
            
            Button {
                controller.isForgetPasswordShown.toggle()
            } label: {
                Text("forgetPassword")
            }
        }
        .padding()
        .navigationTitle("changePassword")
        .navigationBarTitleDisplayMode(.inline)
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
        .sheet(isPresented: $controller.isForgetPasswordShown) {
            ForgetPasswordView()
        }
        .loading($controller.isLoading)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
