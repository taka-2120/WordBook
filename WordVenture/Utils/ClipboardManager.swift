//
//  ClipboardManager.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/29/24.
//

import Foundation
import UIKit

class ClipboardManager {
    static func paste() -> String? {
        return UIPasteboard.general.string
    }
}
