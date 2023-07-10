//
//  PriorityView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/8/23.
//

import SwiftUI

struct PriorityView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject private var controller: WordController
    
    @Binding private var selectedPriority: Priority
    
    init(selectedPriority: Binding<Priority>) {
        self._selectedPriority = selectedPriority
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                DismissButton(dismiss, colorScheme)
            }
            
            ForEach(Priority.allCases, id: \.self) { priority in
                Button {
                    selectedPriority = priority
                } label: {
                    let isSelected = selectedPriority == priority
                    
                    HStack {
                        Text(priority.label)
                        Spacer()
                        Image(systemName: priority.symbol)
                    }
                    .foregroundStyle(priority.color)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.blue, lineWidth: isSelected ? 2 : 0)
                    }
                    .shadow(color: (isSelected ? Color.blue : Color.black).opacity(0.15), radius: 15, y: 4)
                }

            }
            Spacer()
        }
        .padding()
        .animation(.bouncy, value: selectedPriority)
    }
}
