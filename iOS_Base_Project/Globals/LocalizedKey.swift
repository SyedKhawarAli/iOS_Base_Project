//
//  LocalizedKey.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/19/21.
//

import Foundation

enum LocalizedKey: String {
    var string: String {
        guard let language = UserDefaultsManager.appLanguage else {
            return NSLocalizedString(rawValue, comment: "")
        }
        return rawValue.localized(language)
    }

    case ok
    case urlNotFound
    case somethingWentWrong
}
