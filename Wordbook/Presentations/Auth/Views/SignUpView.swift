//
//  SignUpView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject private var controller = AuthController()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Nice to Meet You!")
                .font(.title)
                .bold()
            
            Spacer()
            
            Image("SignUp")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            HStack(spacing: 15) {
                Image(systemName: "person")
                    .font(.system(size: 18))
                    .frame(width: 30)
                VStack(spacing: 0) {
                    TextField("Username", text: $controller.username)
                        .padding(.vertical)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .controlSize(.large)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .frame(height: 2)
                }
            }
            .padding(.horizontal)
            
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
                controller.signUp()
            } label: {
                Text("Sign Up")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
