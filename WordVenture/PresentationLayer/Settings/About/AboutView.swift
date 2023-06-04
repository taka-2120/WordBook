//
//  AboutView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 15) {
                    Image("LargeIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .cornerRadius(32)
                        .shadow(color: .black.opacity(0.2), radius: 15, y: 4)
                    
                    Text("WordVenture")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Group {
                        Text("version") + Text(" 1.0.0 (Beta 1)")
                    }
                    .foregroundColor(Color(.secondaryLabel))
                    .onTapGesture(count: 7) {
                        UserDefaults.standard.set(false, forKey: isCardModeOpenedKey)
                    }
                }
                
                NavigationLink {
                    ReleaseNotesView()
                } label: {
                    HStack {
                        Text("Release Notes")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    .foregroundColor(Color(.label))
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(15)
                }
                .padding(.top)
                
                NavigationLink {
                    UpcomingView()
                } label: {
                    HStack {
                        Text("Upcoming Features")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    .foregroundColor(Color(.label))
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(15)
                }
                .padding(.top)
                
                Divider()
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    Text("Developer")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 12) {
                        ZStack {
                            Rectangle()
                                .fill(.regularMaterial)
                            Image("Profile")
                                .resizable()
                                .frame(width: 64, height: 64)
                        }
                        .frame(width: 64, height: 64)
                        .cornerRadius(100)
                        
                        Text("Yu Takahashi")
                            .font(.headline)
                        
                        Spacer()
                        
                        Link(destination: URL(string: "https://twitter.com/yutk_941")!) {
                            Image("twitter")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        }
                        
                        Link(destination: URL(string: "https://github.com/taka-2120")!) {
                            Image("github")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .overlay {
                                    Circle().stroke(.white, lineWidth: 2)
                                }
                                .background(.white)
                                .cornerRadius(100)
                        }

                    }
                    .foregroundColor(Color(.label))
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(15)
                }
                
                Link(destination: URL(string: "https://yu-dev.vercel.app/")!) {
                    HStack {
                        Text("My Portfolio")
                        Spacer()
                        Image(systemName: "arrow.up.forward.square")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    .foregroundColor(Color(.label))
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(15)
                }
                .padding(.top)
                
                Link(destination: URL(string: "https://www.buymeacoffee.com/yutakahashi")!) {
                    Image("BuyMeACoffee")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .buttonStyle(PlainButtonStyle())
                .background(Color(.systemGroupedBackground))
                .padding(.top)
                
                Text("If you like this app and your wallet is affordable, please buy me a cup of coffee. It will help me for future updates!")
                    .font(.callout)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
        }
        .navigationTitle("About")
        .background(Color(.systemGroupedBackground))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
