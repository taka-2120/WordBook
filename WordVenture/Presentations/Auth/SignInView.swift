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
                    CustomField("", placeHolder: L10n.email.rawValue, isEmail: true, text: $controller.email)
                        .preferredColorScheme(.light)
                }
                .padding(.horizontal)
                
                HStack(spacing: 15) {
                    Image(systemName: "key.horizontal")
                        .font(.system(size: 18))
                        .frame(width: 30)
                    CustomField("", placeHolder: L10n.password.rawValue, isSecured: true, text: $controller.password)
                        .preferredColorScheme(.light)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    controller.signIn()
                } label: {
                    Text(L10n.signIn.rawValue)
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .padding()
                }
                .frame(maxWidth: 250)
                .background(Color.black)
                .cornerRadius(10)
            }
            .padding()
        }
        .background(Color.primaryAccent)
        .foregroundColor(.black)
        .navigationBarTitleDisplayMode(.inline)
        .alert(L10n.error.rawValue, isPresented: $controller.isErrorShown) {
            Text(L10n.ok.rawValue)
        } message: {
            Text(controller.errorMessage)
        }
        .loading($controller.isLoading)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
