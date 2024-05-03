//
//  SignUpView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var controller = AuthController()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text(L10n.niceToMeetYou.rawValue)
                    .font(.title)
                
                Image(.signUp)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .cornerRadius(30)
                    .padding(.horizontal, 50)
                
                HStack(spacing: 15) {
                    Image(systemName: "person")
                        .font(.system(size: 18))
                        .frame(width: 30)
                    
                    VStack(alignment: .leading) {
                        CustomField("", placeHolder: L10n.email.rawValue, text: $controller.username)
                            .preferredColorScheme(.light)
                        Text(LocalizedStringKey(stringLiteral: RegexType.usernameRegex.notes))
                            .font(.callout)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 15) {
                    Image(systemName: "at")
                        .font(.system(size: 18))
                        .frame(width: 30)
                    CustomField("", placeHolder: L10n.email.rawValue, keyType: .email, text: $controller.email)
                        .preferredColorScheme(.light)
                }
                .padding(.horizontal)
                
                HStack(spacing: 15) {
                    Image(systemName: "key.horizontal")
                        .font(.system(size: 18))
                        .frame(width: 30)
                    
                    VStack(alignment: .leading) {
                        CustomField("", placeHolder: L10n.password.rawValue, keyType: .password, text: $controller.password)
                            .preferredColorScheme(.light)
                        Text(LocalizedStringKey(stringLiteral: RegexType.passwordRegex.notes))
                            .font(.callout)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                VentureButton(label: L10n.signUp.rawValue) {
                    controller.signUp()
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.primaryAccent)
        .foregroundColor(.black)
        .dialog(manager: controller.dialogManager)
        .loading($controller.isLoading)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
