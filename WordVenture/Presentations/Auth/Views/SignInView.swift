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
                Text("welcomeBack")
                    .font(.title)
                    .bold()
                
                Image("signIn")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 50)
                
                HStack(spacing: 15) {
                    Image(systemName: "at")
                        .font(.system(size: 18))
                        .frame(width: 30)
                    VStack(spacing: 0) {
                        TextField("email", text: $controller.email)
                            .padding(.vertical)
                            .controlSize(.large)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
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
                        SecureField("password", text: $controller.password)
                            .padding(.vertical)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .frame(height: 2)
                    }
                }
                .padding(.horizontal)
                
                Button {
                    controller.signIn()
                } label: {
                    Text("signIn")
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
        .navigationBarTitleDisplayMode(.inline)
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
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
