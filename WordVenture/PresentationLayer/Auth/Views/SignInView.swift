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
                
                Image("SignIn")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .cornerRadius(30)
                    .padding(.horizontal, 50)
                
                HStack(spacing: 15) {
                    Image(systemName: "at")
                        .font(.system(size: 18))
                        .frame(width: 30)
                    CustomField("", placeHolder: "email", isEmail: true, text: $controller.email)
                        .preferredColorScheme(.light)
                }
                .padding(.horizontal)
                
                HStack(spacing: 15) {
                    Image(systemName: "key.horizontal")
                        .font(.system(size: 18))
                        .frame(width: 30)
                    CustomField("", placeHolder: "password", isSecured: true, text: $controller.password)
                        .preferredColorScheme(.light)
                }
                .padding(.horizontal)
                
                Spacer()
                
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
        .background(Color.primaryAccent)
        .foregroundColor(.black)
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
