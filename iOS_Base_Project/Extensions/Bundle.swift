//
//  Bundle.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 3/1/21.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    var fullVersionString: String {
        return "\(releaseVersionNumber ?? "1.0").\(buildVersionNumber ?? "1")"
    }
}
