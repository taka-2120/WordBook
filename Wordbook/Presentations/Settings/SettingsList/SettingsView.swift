//
//  SettingsView.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller = SettingsController()
    
    var body: some View {
        NavigationStack(path: $controller.settingsPathes) {
            List {
                Section("Account") {
                    SettingsItem(kinds: .link, leftLabel: "Change Username", leftIconName: "person", rightLabel: "\(controller.username)", destination: .changeUsername)
                    SettingsItem(kinds: .link, leftLabel: "Change Email", leftIconName: "at", destination: .changeEmail)
                    SettingsItem(kinds: .link, leftLabel: "Change Password", leftIconName: "key", destination: .changePassword)
                }

                Section("Info") {
                    SettingsItem(kinds: .normal, leftLabel: "Version", leftIconName: "info", rightLabel: "1.0.0 Beta 1")
                    SettingsItem(kinds: .link, leftLabel: "Privacy Policy", leftIconName: "lock.fill", destination: .privacyPolicy)
                    SettingsItem(kinds: .link, leftLabel: "Credits", leftIconName: "quote.opening", destination: .credits)
                }
                
                Section("Denger Zone") {
                    Button {
                        controller.isSignOutPromptShown.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "door.left.hand.open")
                            Text("Sign Out")
                        }
                        .foregroundColor(.orange)
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Account")
                        }
                        .foregroundColor(.red)
                    }
                }
                
                Link(destination: URL(string: "https://www.buymeacoffee.com/yutakahashi")!) {
                    Image("BuyMeACoffee")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .buttonStyle(PlainButtonStyle())
                .listRowInsets(EdgeInsets())
                .background(Color(.systemGroupedBackground))
            }
            .environmentObject(controller)
            .navigationBarTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .navigationDestination(for: SettingsNavStack.self) { path in
                switch path {
                case .changeUsername: ChangeUsernameView()
                case .changeEmail: ChangeEmailView()
                case .changePassword: ChangePasswordView()
                case .privacyPolicy: PrivacyPolicyView()
                case .credits: CreditsView()
                case .deleteAccount: EmptyView()
                }
            }
            .alert("Do you really want to sign out?", isPresented: $controller.isSignOutPromptShown) {
                Button(role: .destructive) {
                    controller.signOut()
                } label: {
                    Text("OK")
                }
            } message: {
                Text("Your data will be kept on the database.")
            }
            .loading($controller.isLoading)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
