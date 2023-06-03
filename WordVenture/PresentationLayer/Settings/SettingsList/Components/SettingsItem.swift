//
//  SettingsItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

enum SettingsItemKinds {
    case normal, button, link
}

struct SettingsItem: View {
    @EnvironmentObject private var controller: SettingsController
    
    var kinds: SettingsItemKinds
    var leftLabel: LocalizedStringKey
    var leftIconName: String?
    var rightLabel: LocalizedStringKey?
    var rightIconName: String?
    var destination: SettingsNavStack?
    @Binding var pathes: [SettingsNavStack]
    var function: (() -> ())?
    
    var body: some View {
        switch kinds {
        case .normal:
            HStack {
                if let leftIconName = leftIconName {
                    Image(systemName: leftIconName)
                        .frame(width: 30)
                        .foregroundColor(Color(.label))
                }
                
                Text(leftLabel)
                    .foregroundColor(Color(.label))
                Spacer()
                
                (rightLabel != nil) ? AnyView(Text(rightLabel!).foregroundColor(.gray)) : AnyView(Image(systemName: rightIconName!))
            }
        case .button:
            Button(action: function ?? {
                //Error
            }, label: {
                HStack {
                    if let leftIconName = leftIconName {
                        Image(systemName: leftIconName)
                            .frame(width: 30)
                            .foregroundColor(Color(.label))
                    }
                    
                    Text(leftLabel)
                        .foregroundColor(Color(.label))
                    
                    Spacer()
                    if let rightLabel = rightLabel {
                        Text(rightLabel)
                            .foregroundColor(.gray)
                            .font(.callout)
                    } else if let rightIconName = rightIconName {
                        Image(systemName: rightIconName)
                    }
                }
            })
        case .link:
            Button {
                pathes = [destination!]
            } label: {
                HStack {
                    if let leftIconName = leftIconName {
                        Image(systemName: leftIconName)
                            .frame(width: 30)
                            .foregroundColor(Color(.label))
                    }
                    
                    Text(leftLabel)
                        .foregroundColor(Color(.label))
                    
                    Spacer()
                    if let rightLabel = rightLabel {
                        Text(rightLabel)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    Image(systemName: rightIconName ?? "chevron.forward")
                        .foregroundColor(.gray)
                        .imageScale(.small)
                }
            }
        }
        
    }
}
