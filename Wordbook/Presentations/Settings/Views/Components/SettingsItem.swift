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
    var kinds: SettingsItemKinds
    var leftLabel: String
    var leftIconName: String?
    var rightLabel: String?
    var rightIconName: String?
    var destination: AnyView?
    var function: (() -> ())?
    
    var body: some View {
        switch kinds {
        case .normal:
            HStack {
                (leftIconName != nil) ? Image(systemName: leftIconName!) : nil
                Text(leftLabel)
                    .foregroundColor(Color(.label))
                    .fontWeight(.semibold)
                Spacer()
                (rightLabel != nil) ? AnyView(Text(rightLabel!)) : AnyView(Image(systemName: rightIconName!))
            }
            .padding()
            .background()
            .cornerRadius(15)
            .shadow(color: Color(.systemGray5), radius: 10)
            .padding(.horizontal)
            .padding(.vertical, 5)
        case .button:
            Button(action: function ?? {
                //Error
            }, label: {
                HStack {
                    Text(leftLabel)
                        .foregroundColor(Color(.label))
                        .fontWeight(.semibold)
                    Spacer()
                    if rightLabel != nil {
                        Text(rightLabel!)
                    } else if rightIconName != nil {
                        Image(systemName: rightIconName!)
                    }
                }
            })
            .padding()
            .background()
            .cornerRadius(15)
            .shadow(color: Color(.systemGray5), radius: 10)
            .padding(.horizontal)
            .padding(.vertical, 5)
        case .link:
            NavigationLink(destination: destination) {
                HStack {
                    Text(leftLabel)
                        .foregroundColor(Color(.label))
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: rightIconName ?? "chevron.forward")
                }
            }
            .padding()
            .background()
            .cornerRadius(15)
            .shadow(color: Color(.systemGray5), radius: 10)
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        
    }
}

struct SettingsItem_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItem(kinds: .normal, leftLabel: "Version", rightLabel: "1.0.0 Beta")
        SettingsItem(kinds: .button, leftLabel: "Sign Out", function: {
            print("done")
        })
        SettingsItem(kinds: .link, leftLabel: "Notifications", destination: AnyView(EmptyView()))
    }
}
