//
//  Environment.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/19/21.
//

import Foundation

enum Environment {
    case development
    case staging
    case production

    static var current: Environment { return .production }

    static var baseUrl: URL? {
        switch current {
        case .development: return URL(string: "https://qa.zytrack.ch/api/v1/")
        case .staging: return URL(string: "https://zytrack-staging.herokuapp.com/api/v1/")
        case .production: return URL(string: "https://app.zytrack.ch/api/v1/")
        }
    }
}

