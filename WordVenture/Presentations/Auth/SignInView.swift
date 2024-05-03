//
//  SignInView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var controller = AuthController()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text(L10n.welcomeBack.rawValue)
                    .font(.title)
                    .bold()
                
                Image(.signIn)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .cornerRadius(30)
                    .padding(.horizontal, 50)
                
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
                    CustomField("", placeHolder: L10n.password.rawValue, keyType: .password, text: $controller.password)
                        .preferredColorScheme(.light)
                }
                .padding(.horizontal)
                
                Spacer()
                
                VentureButton(label: L10n.signIn.rawValue) {
                    controller.signIn()
                }
            }
            .padding()
        }
        .background(Color.primaryAccent)
        .foregroundColor(.black)
        .navigationBarTitleDisplayMode(.inline)
        .dialog(manager: controller.dialogManager)
        .loading($controller.isLoading)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
