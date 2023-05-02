//
//  ChangeUsernameView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI

struct ChangeUsernameView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var controller = SettingsController()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Change Username")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            CustomField("New Username", text: $controller.username)
            
            Spacer()
            
            Button {
                controller.updateUsername(dismiss)
            } label: {
                Text("Update")
                    .foregroundColor(Color(.systemBackground))
                    .font(.title3)
                    .padding()
            }
            .frame(maxWidth: 250)
            .background(Color(.label))
            .cornerRadius(15)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .loading($controller.isLoading)
    }
}

struct ChangeUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUsernameView()
    }
}
