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
                
                Text("cardDescription")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
                    .padding([.bottom, .horizontal])
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("diveIn")
                        .foregroundColor(Color(.systemBackground))
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: 250)
                }
                .background(Color(.label))
                .cornerRadius(15)
                
                Text("betaNotes")
                    .font(.callout)
                    .foregroundColor(Color(.secondaryLabel))
                    .multilineTextAlignment(.center)
                    .padding(8)

            }
            .navigationTitle("meetCard")
        }
    }
}

struct CardIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        CardIntroductionView()
    }
}
