//
//  FieldItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/30/23.
//

import SwiftUI

struct FieldItem: View {
    
    let label: LocalizedStringKey
    @Binding var array: [String]
    
    init(_ label: LocalizedStringKey, array: Binding<[String]>) {
        self.label = label
        self._array = array
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .padding(.top, 10)
            ForEach(Array(array.enumerated()), id: \.offset) { index, sentence in
                HStack {
                    Text("\(index + 1).")
                        .frame(minWidth: 0, maxWidth: 20)
                    TextField("Example \(index + 1)", text: $array[index])
                        .padding(8)
                        .background(Color(.systemGray6))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(10)
                    Button {
                        array.remove(at: index)
                    } label: {
                        Image(systemName: "minus")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
