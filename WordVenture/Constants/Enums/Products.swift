//
//  Products.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import SwiftUI

enum UnlimitedPeriod: CaseIterable {
    case monthly, annually
}

extension UnlimitedPeriod {
    var id: String {
        switch self {
        case .monthly:
            return "yutakahashi.WordVenture.Unlimited_Monthly"
        case .annually:
            return "yutakahashi.WordVenture.Unlimited_Annually"
        }
    }
    
    var periodName: String {
        switch self {
        case .monthly:
            return "monthly"
        case .annually:
            return "annually"
        }
    }
    
    // Monthly Price for each period
    var price: Double {
        switch self {
        case .monthly: return 2.99
        case .annually: return 29.99 / 12
        }
    }
}
