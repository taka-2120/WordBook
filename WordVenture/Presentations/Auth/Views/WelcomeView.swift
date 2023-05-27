//
//  WelcomeView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var authPathes: [AuthMethod] = []
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue.withAlphaComponent(0.8)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
    }
    
    var body: some View {
        NavigationStack(path: $authPathes) {
            VStack {
                HStack {
                    Text("Welcome to")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding([.horizontal, .top])
                
                HStack {
                    VStack(spacing: 0) {
                        Text("WordVenture")
                            .font(.largeTitle)
                            .bold()
                            .padding(12)
                        Rectangle()
                            .fill(Color.black)
                            .frame(height: 4)
                            .frame(minWidth: 0)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .padding(.leading, 100)
                
                TabView {
                    VStack {
                        Image("BookStack")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(30)
                        Text("Fooooo")
                    }
                    .padding()
                    .tag(0)
                    
                    VStack {
                        Image("Brain")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(30)
                        Text("Fooooo")
                    }
                    .padding()
                    .tag(1)
                    
                    VStack {
                        Image("CardStack")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(30)
                        Text("Fooooo")
                    }
                    .padding()
                    .tag(2)
                }
                .background(Color.white)
                .cornerRadius(30)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .background(Color.clear)
                .padding()
                
                HStack {
                    
                    Button {
                        authPathes = [.signUp]
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
                    
                    
                    Button {
                        authPathes = [.signIn]
                    } label: {
                        Text("signIn")
                            .foregroundColor(Color(.label))
                            .font(.title3)
                            .bold()
                            .padding()
                    }
                    .frame(maxWidth: 250)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                }
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.primaryAccent)
            .navigationDestination(for: AuthMethod.self) { method in
                switch method {
                case .signUp: SignUpView()
                case .signIn: SignInView()
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
