//
//  ChangeUsernameView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI

struct ChangeUsernameView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller = ChangeUsernameController()
    
    var body: some View {
        VStack(spacing: 15) {
            CustomField("newUsername", text: $controller.username)
            
            Spacer()
            
            Button {
                controller.updateUsername(dismiss)
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
        .navigationTitle("changeUsername")
        .navigationBarTitleDisplayMode(.inline)
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
        .loading($controller.isLoading)
    }
}

struct ChangeUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUsernameView()
    }
}
