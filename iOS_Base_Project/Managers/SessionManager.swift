//
//  SessionManager.swift
//  Level Up
//
//  Created by BrainX Technologies on 04/11/2020.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()

    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showBlockedUser),
            name: .blockedUser,
            object: nil
        )
    }

    // MARK: Properties

    public var user: ZyTrackUser?

    public var isUserLogin: Bool {
        return user != nil && user?.accessToken != nil
    }

    // MARK: - Public Methods

    public func loadSession() {
        user = ZyTrackUser(JSON: UserDefaultsManager.user)
        guard let _ = user?.accessToken else {
            user = nil
            return
        }
    }

    public func saveUser(user: ZyTrackUser) {
        self.user = user
        if UserDefaultsManager.rememberMe {
            UserDefaultsManager.user = user.toJSON()
        }
    }

    public func logout() {
        UserDefaultsManager.user = [:]
        user = nil
        UserDefaultsManager.resetDefaults()
    }

    @objc
    func showBlockedUser() {
        // _ = Helpers.showBlockedUserScreen()
    }
}
