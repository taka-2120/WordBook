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
    @State private var settingsPathes: [SettingsNavStack] = []
    
    var body: some View {
        NavigationStack(path: $settingsPathes) {
            List {
                Section("Account") {
                    SettingsItem(kinds: .link, leftLabel: "Change Username", leftIconName: "person", rightLabel: "\(controller.username)", destination: .changeUsername, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "Change Email", leftIconName: "at", destination: .changeEmail, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "Change Password", leftIconName: "key", destination: .changePassword, pathes: $settingsPathes)
                }

                Section("Info") {
                    SettingsItem(kinds: .normal, leftLabel: "Version", leftIconName: "info", rightLabel: "1.0.0 Beta 1", pathes: $settingsPathes)
                        .onTapGesture(count: 7) {
                            UserDefaults.standard.set(false, forKey: isCardModeOpenedKey)
                        }
                    SettingsItem(kinds: .link, leftLabel: "Privacy Policy", leftIconName: "lock.fill", destination: .privacyPolicy, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "Credits", leftIconName: "quote.opening", destination: .credits, pathes: $settingsPathes)
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
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "trash")
                                Text("Delete Account")
                            }
                            .foregroundColor(.gray)
                            
                            Text("Account deletion is currently disabled. This will be enabled in future update.")
                                .font(.caption)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                    .disabled(true)
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
            .onChange(of: settingsPathes) { newValue in
                if newValue == [] {
                    controller.fetchInformation()
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
