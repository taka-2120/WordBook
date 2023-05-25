//
//  CardIntroductionView.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/18/23.
//

import SwiftUI

struct CardIntroductionView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("CardIntro")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)
                
                Spacer()
                
                Text("Welcome to Study Card!")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(10)
                Text("The front of the card is the original word, and the back is translated word. You can tap to flip the card and easily memorize each word 🙌")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
                    .padding([.bottom, .horizontal])
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Let's Dive In!")
                        .foregroundColor(Color(.systemBackground))
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: 250)
                }
                .background(Color(.label))
                .cornerRadius(15)
                
                Text("This is a beta feature.\nMany features will be comming soon.")
                    .font(.callout)
                    .foregroundColor(Color(.secondaryLabel))
                    .multilineTextAlignment(.center)
                    .padding(8)

            }
            .navigationTitle("Meet Study Card (Beta)")
        }
    }
}

struct CardIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        CardIntroductionView()
    }
}
