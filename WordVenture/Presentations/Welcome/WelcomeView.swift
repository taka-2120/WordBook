//
//  WelcomeView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var controller = WelcomeController()
    
    var body: some View {
        NavigationStack(path: $controller.authNavPaths) {
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
                    IntroItem(image: .brain, description: L10n.apiIntro.rawValue)
                    .padding()
                    .tag(1)
                    
                    IntroItem(image: .cardStack, description: L10n.cardIntro.rawValue)
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
                    VentureButton(
                        label: L10n.signUp.rawValue,
                        foregroundColor: .white,
                        backgroundColor: .black
                    ) {
                        controller.navigate(to: .signUp)
                    }
                    
                    VentureButton(
                        label: L10n.signUp.rawValue,
                        foregroundColor: .black,
                        backgroundColor: .clear
                    ) {
                        controller.navigate(to: .signUp)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                }
                
                VStack(spacing: 8) {
                    Text(L10n.usingAppNotes.rawValue)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .foregroundStyle(Color(.secondaryLabel))
                    
                    Button {
                        controller.showPrivacyPolicy()
                    } label: {
                        Text(L10n.privacyPolicy.rawValue)
                            .font(.callout)
                            .underline()
                    }
                    
                    Button {
                        controller.showTermsAndConditions()
                    } label: {
                        Text(L10n.termsAndConditions.rawValue)
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
            .sheet(isPresented: $controller.isPrivacyPolicyShown, content: { PrivacyPolicyView(selfNavigatable: true) })
            .sheet(isPresented: $controller.isTermsANdConditionsShown, content: { TermsAndConditionsView(selfNavigatable: true) })
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
