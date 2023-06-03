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
    
    var period: LocalizedStringKey {
        switch self {
        case .monthly:
            return "monthly"
        case .annually:
            return "annually"
        }
    }
}


enum Plan: CaseIterable {
    case free, removeAds, unlimited
}

extension Plan {
    var id: String {
        switch self {
        case .removeAds:
            return "yutakahashi.WordVenture.Remove_Ads"
        default:
            return ""
        }
    }
    
    var name: LocalizedStringKey {
        switch self {
        case .free:
            return "free"
        case .removeAds:
            return "removeAds"
        case .unlimited:
            return "Unlimited"
        }
    }
    
    var period: LocalizedStringKey {
        switch self {
        case .removeAds:
            return "lifetime"
        default:
            return ""
        }
    }
    
    var description: LocalizedStringKey {
        switch self {
        case .free:
            return "freeDescription"
        case .removeAds:
            return "removeAdsDescription"
        case .unlimited:
            return "unlimitedDescription"
        }
    }
    
    var contents: [String] {
        switch self {
        case .free:
            return ["ads", "textGenFree", "imageSearchFree"]
        case .removeAds:
            return ["noAds", "textGenRemoveAds", "imageSearchRemoveAds"]
        case .unlimited:
            return ["noAds", "textGenUnlimited", "imageSearchUnlimited"]
        }
    }
}
