//
//  SettingsView.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var controller = SettingsController()
    @State private var settingsPathes: [SettingsNavStack] = []
    
    var body: some View {
        NavigationStack(path: $settingsPathes) {
            List {
                Section("account") {
                    SettingsItem(kinds: .link, leftLabel: "changeUsername", leftIconName: "person", rightLabel: "\(controller.username)", destination: .changeUsername, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "changeEmail", leftIconName: "at", destination: .changeEmail, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "changePassword", leftIconName: "key", destination: .changePassword, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "plans", leftIconName: "dollarsign.circle", destination: .plans, pathes: $settingsPathes)
                }

                Section("info") {
                    SettingsItem(kinds: .link, leftLabel: "about \("WordVenture")", leftIconName: "info", destination: .about, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "privacyPolicy", leftIconName: "lock.fill", destination: .privacyPolicy, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "termsAndConditions", leftIconName: "network.badge.shield.half.filled", destination: .termsAndConditions, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "licenses", leftIconName: "puzzlepiece", destination: .licenses, pathes: $settingsPathes)
                    SettingsItem(kinds: .link, leftLabel: "credits", leftIconName: "quote.opening", destination: .credits, pathes: $settingsPathes)
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
            }
            .environmentObject(controller)
            .navigationBarTitle("settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DismissButton(dismiss, colorScheme)
                }
            }
            .navigationDestination(for: SettingsNavStack.self) { path in
                switch path {
                case .changeUsername: ChangeUsernameView()
                case .changeEmail: ChangeEmailView()
                case .changePassword: ChangePasswordView()
                case .privacyPolicy: PrivacyPolicyView()
                case .licenses: LicensesView()
                case .credits: CreditsView()
                case .plans: PlansView()
                case .deleteAccount: DeleteAccountView()
                case .about: AboutView()
                case .termsAndConditions: TermsAndConditionsView()
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
