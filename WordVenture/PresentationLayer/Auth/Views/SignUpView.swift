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
                Text("niceToMeetYou")
                    .font(.title)
                    .bold()
                
                Image("SignUp")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .cornerRadius(30)
                    .padding(.horizontal, 50)
                
                HStack(spacing: 15) {
                    Image(systemName: "person")
                        .font(.system(size: 18))
                        .frame(width: 30)
                    CustomField("", placeHolder: "username", text: $controller.username)
                        .preferredColorScheme(.light)
                }
                .padding(.horizontal)
                
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
                    controller.signUp()
                } label: {
                    Text("signUp")
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
        .background(Color.primaryAccent)
        .foregroundColor(.black)
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
        .loading($controller.isLoading)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
