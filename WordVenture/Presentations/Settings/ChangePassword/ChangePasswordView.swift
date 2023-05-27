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
    
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var reNewassword = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Text("changePassword")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            CustomField("oldPassword", isSecured: true, text: $controller.password)
            CustomField("newPassword", isSecured: true, text: $controller.newPassword)
            CustomField("reNewPassword", isSecured: true, text: $controller.reNewPassword)
            
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

        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
        .loading($controller.isLoading)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
