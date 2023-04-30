//
//  ChangeUsernameView.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/29/23.
//

import SwiftUI

struct ChangeUsernameView: View {
    
    @State private var username = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Change Username")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            CustomField("New Username", text: $username)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Update")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
            }
            .frame(maxWidth: 250)
            .background(Color.black)
            .cornerRadius(15)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChangeUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUsernameView()
    }
}
