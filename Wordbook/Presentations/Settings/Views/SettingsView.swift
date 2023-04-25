//
//  SettingsView.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")) {
                    NavigationLink(destination: ChangeEmailView()) {
                        Text("Change Email")
                    }
                    NavigationLink(destination: ChangeUsernameView()) {
                        Text("Change Username")
                    }
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change Password")
                    }
                }

                Section(header: Text("Info")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                    }
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("Privacy Policy")
                    }
                    NavigationLink(destination: CreditsView()) {
                        Text("Credits")
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
