//
//  Dashboard.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct Dashboard: View {
    @Binding var wordCount: Int
    @Binding var studied: Int
    @Binding var missed: Int
    
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [hexColor(0x639CFF), hexColor(0x4FB0FF)]), startPoint: .leading, endPoint: .topTrailing))
                        .frame(maxWidth: 80, maxHeight: 80)
                        .shadow(radius: 5, x: 2, y: 2)
                    Text("\(wordCount)")
                        .foregroundColor(Color.white)
                        .font(.system(size: 32, design: .rounded))
                        .fontWeight(.bold)
                }
                Text("words")
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 14))
                    .fontWeight(.bold)
            }
            .padding()
            
            VStack {
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [hexColor(0xFF9063), hexColor(0xFFAA4F)]), startPoint: .leading, endPoint: .topTrailing))
                        .frame(maxWidth: 80, maxHeight: 80)
                        .shadow(radius: 5, x: 2, y: 2)
                    Text("\(studied)")
                        .foregroundColor(Color.white)
                        .font(.system(size: 32, design: .rounded))
                        .fontWeight(.bold)
                }
                Text("mins")
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 14))
                    .fontWeight(.bold)
            }
            .padding()
            
            VStack {
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [hexColor(0xFF64B6), hexColor(0xFF5082)]), startPoint: .leading, endPoint: .topTrailing))
                        .frame(maxWidth: 80, maxHeight: 80)
                        .shadow(radius: 5, x: 2, y: 2)
                    Text("\(missed)")
                        .foregroundColor(Color.white)
                        .font(.system(size: 32, design: .rounded))
                        .fontWeight(.bold)
                }
                Text("misssed")
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 14))
                    .fontWeight(.bold)
            }
            .padding()
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(wordCount: .constant(14), studied: .constant(30), missed: .constant(0))
    }
}
