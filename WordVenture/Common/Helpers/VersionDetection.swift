//
//  VersionDetection.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/12/23.
//

import Foundation

func detectVersion() -> String {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    
    let isBeta = Bundle.main.infoDictionary?["isBeta"] as? Bool ?? true
    if isBeta {
        let bundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        return appVersion + " (Beta \(bundleVersion))"
    }
    
    return appVersion
}
