//
//  NukeConfig.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/12/23.
//

import Nuke
import Foundation

let customPipeline = ImagePipeline {
    $0.dataCache = try? DataCache(name: bundleId ?? defaultBundleId)
    $0.dataCachePolicy = .automatic
}
