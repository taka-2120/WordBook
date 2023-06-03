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
                Section("account") {
                    SettingsItem(kinds: .link, leftLabel: "changeUsername", leftIconName: "person", rightLabel: "\(controller.username)", destination: .changeUsername, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "changeEmail", leftIconName: "at", destination: .changeEmail, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "changePassword", leftIconName: "key", destination: .changePassword, pathes: $settingsPathes)
                }

                Section("info") {
                    SettingsItem(kinds: .normal, leftLabel: "version", leftIconName: "info", rightLabel: "1.0.0 Beta 1", pathes: $settingsPathes)
                        .onTapGesture(count: 7) {
                            UserDefaults.standard.set(false, forKey: isCardModeOpenedKey)
                        }
                    SettingsItem(kinds: .link, leftLabel: "privacyPolicy", leftIconName: "lock.fill", destination: .privacyPolicy, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "credits", leftIconName: "quote.opening", destination: .credits, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "plans", leftIconName: "dollarsign.circle", destination: .plans, pathes: $settingsPathes)
                }
                
                Section("dengerZone") {
                    Button {
                        controller.isSignOutPromptShown.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "door.left.hand.open")
                            Text("signOut")
                        }
                        .foregroundColor(.orange)
                    }
                    
                    NavigationLink(destination: { DeleteAccountView() }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("deleteAccount")
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
            .navigationBarTitle("settings")
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
                case .plans: PlansView()
                case .deleteAccount: DeleteAccountView()
                }
            }
            .onChange(of: settingsPathes) { newValue in
                if newValue == [] {
                    controller.fetchInformation()
                }
            }
            .alert("signOutConfirmationTitle", isPresented: $controller.isSignOutPromptShown) {
                Button(role: .destructive) {
                    controller.signOut()
                } label: {
                    Text("yes")
                }
                Button(role: .cancel) {
                    controller.isSignOutPromptShown = false
                } label: {
                    Text("no")
                }
            } message: {
                Text("signOutConfirmationMessage")
            }
            .alert("error", isPresented: $controller.isErrorShown) {
                Text("OK")
            } message: {
                Text(controller.errorMessage)
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
