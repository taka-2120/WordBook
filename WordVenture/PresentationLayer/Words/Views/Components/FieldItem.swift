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
    let isEditing: Bool
    
    init(_ label: LocalizedStringKey, array: Binding<[String]>, isEditing: Bool = true) {
        self.label = label
        self._array = array
        self.isEditing = isEditing
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .padding(.top, 10)
            ForEach(Array(array.enumerated()), id: \.offset) { index, sentence in
                if isEditing {
                    HStack {
                        Text("\(index + 1).")
                            .frame(minWidth: 0, maxWidth: 20)
                        TextField("Example \(index + 1)", text: $array[index])
                            .padding(8)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .cornerRadius(10)
                        Button {
                            array.remove(at: index)
                        } label: {
                            Image(systemName: "minus")
                                .foregroundColor(.gray)
                        }
                    }
                } else {
                    HStack(alignment: .top) {
                        Text("\(index + 1).")
                            .frame(minWidth: 0, maxWidth: 20)
                        Text(array[index])
                    }
                    .padding(.vertical, 3)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}
