//
//  WelcomeView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var authPathes: [AuthMethod] = []
    @State private var isPrivacyPolicyShown = false
    @State private var isTermsAndConditionsShown = false
    
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
                            .fill(.black)
                            .frame(height: 4)
                            .frame(minWidth: 0)
                    }
                    .background(.white)
                    .cornerRadius(10)
                }
                .padding(.leading, 100)
                
                TabView {
//                    VStack {
//                        Image("BookStack")
//                            .resizable()
//                            .scaledToFit()
//                            .cornerRadius(30)
//                        Text("Fooooo")
//                            .padding(.bottom, 40)
//                    }
//                    .padding()
//                    .tag(0)
                    
                    VStack {
                        Image(.brain)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(30)
                        Text("apiIntro")
                            .padding(.vertical)
                    }
                    .padding()
                    .tag(1)
                    
                    VStack {
                        Image(.cardStack)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(30)
                        Text("cardIntro")
                            .padding(.vertical)
                    }
                    .padding()
                    .tag(2)
                }
                .background(Color.white)
                .font(.title3)
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
                            .font(.title3)
                            .bold()
                            .padding()
                    }
                    .frame(maxWidth: 250)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2)
                    }
                }
                
                VStack(spacing: 8) {
                    Text("usingAppNotes")
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .foregroundStyle(Color(.secondaryLabel))
                    
                    Button {
                        isPrivacyPolicyShown.toggle()
                    } label: {
                        Text("privacyPolicy")
                            .font(.callout)
                            .underline()
                    }
                    
                    Button {
                        isTermsAndConditionsShown.toggle()
                    } label: {
                        Text("termsAndConditions")
                            .font(.callout)
                            .underline()
                    }
                }
                .padding(.top, 10)
            }
            .foregroundColor(.black)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.primaryAccent)
            .sheet(isPresented: $isPrivacyPolicyShown, content: { PrivacyPolicyView(selfNavigatable: true) })
            .sheet(isPresented: $isTermsAndConditionsShown, content: { TermsAndConditionsView(selfNavigatable: true) })
            .navigationDestination(for: AuthMethod.self) { method in
                switch method {
                case .signUp: SignUpView()
                case .signIn: SignInView()
                }
            }
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue.withAlphaComponent(0.8)
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
