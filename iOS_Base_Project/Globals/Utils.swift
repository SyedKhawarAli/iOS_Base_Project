//
//  Utils.swift
//  BaseCode
//
//  Created by BrainX Technologies on 01/07/2019.
//  Copyright © 2019 Brainx Technologies. All rights reserved.
//

import UIKit
import SystemConfiguration
import UserNotifications

class Utils {
    
    static func showOkAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showActionAlert(title: String, message: String, viewController: UIViewController, alertActions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for alertAction in alertActions {
            alertController.addAction(alertAction)
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func generateUUIDString() -> String {
        var st = UUID().uuidString.components(separatedBy: " ").last!.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        st = st.replacingOccurrences(of: "-", with: "", options: .literal, range: nil).lowercased()
        return st
    }
    
    static func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
        
    static func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    static func setBadgeIndicator(badgeCount: Int) {
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in }
        } else {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        }
        application.registerForRemoteNotifications()
        application.applicationIconBadgeNumber = badgeCount
    }
}
