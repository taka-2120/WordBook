//
//  ChangePasswordView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI

struct ChangePasswordView: View {
    
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
            
            CustomField("Old Password", isSecured: true, text: $oldPassword)
            CustomField("New Password", isSecured: true, text: $newPassword)
            CustomField("Re-enter New Password", isSecured: true, text: $reNewassword)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Update")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
            }
            .frame(maxWidth: 250)
            .background(Color.black)
            .cornerRadius(15)

        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
