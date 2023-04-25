//
//  SignInView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject private var controller = AuthController()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Welcome Back!")
                .font(.title)
                .bold()
            
            Spacer()
            
            Image("SignIn")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            HStack(spacing: 15) {
                Image(systemName: "at")
                    .font(.system(size: 18))
                    .frame(width: 30)
                VStack(spacing: 0) {
                    TextField("Email", text: $controller.email)
                        .padding(.vertical)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .controlSize(.large)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .frame(height: 2)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 15) {
                Image(systemName: "key.horizontal")
                    .font(.system(size: 18))
                    .frame(width: 30)
                VStack(spacing: 0) {
                    SecureField("Password", text: $controller.password)
                        .padding(.vertical)
                        .keyboardType(.emailAddress)
                        .controlSize(.large)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .frame(height: 2)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                controller.signIn()
            } label: {
                Text("Sign In")
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
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
