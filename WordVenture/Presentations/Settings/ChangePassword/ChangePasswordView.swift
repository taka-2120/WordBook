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
            Text("Change Password")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            CustomField("Old Password", isSecured: true, text: $controller.password)
            CustomField("New Password", isSecured: true, text: $controller.newPassword)
            CustomField("Re-enter New Password", isSecured: true, text: $controller.reNewPassword)
            
            Spacer()
            
            Button {
                controller.updatePassword(dismiss)
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
        .alert("Error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorType.rawValue)
        }
        .loading($controller.isLoading)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
