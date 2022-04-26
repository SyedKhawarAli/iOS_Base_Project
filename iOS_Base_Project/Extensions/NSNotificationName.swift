//
//  NSNotificationName.swift
//  Level Up
//
//  Created by BrainX Technologies on 17/12/2020.
//

import Foundation

extension NSNotification.Name {
    static let blockedUser = NSNotification.Name(rawValue: "blockedUserNotification")
    static let fcmTokenReceived = Notification.Name("FCMToken")
    static let onUpdateSelectedMenuItem = Notification.Name("onUpdateSelectedMenuItem")
}
