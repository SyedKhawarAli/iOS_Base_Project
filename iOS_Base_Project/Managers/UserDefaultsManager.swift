//
//  UserDefaultsManager.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 3/1/21.
//

import Foundation

struct UserDefaultsManager {
    @propertyWrapper
    public struct UserDefault<T> {
        public let key: String
        public let defaultValue: T
        init(_ key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }

        public var wrappedValue: T {
            get {
                let oldValue = UserDefaults.standard.object(forKey: key) as? T
                switch oldValue as Any {
                case Optional<Any>.some(let value):
                    return value as! T
                case Optional<Any>.none:
                    return defaultValue
                default:
                    return oldValue ?? defaultValue
                }
            }
            set {
                switch newValue as Any {
                case Optional<Any>.some(let value):
                    UserDefaults.standard.set(value, forKey: key)
                case Optional<Any>.none:
                    UserDefaults.standard.removeObject(forKey: key)
                default:
                    UserDefaults.standard.set(newValue, forKey: key)
                }
            }
        }
    }

    // MARK: Public methods

    static func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

extension UserDefaultsManager {
    @UserDefault("device_token", defaultValue: "")
    static var deviceToken: String

    @UserDefault("user", defaultValue: [:])
    static var user: [String: Any]
    
    @UserDefault("rememberMe", defaultValue: true)
    static var rememberMe: Bool

    @UserDefault("appLanguage", defaultValue: nil)
    static var appLanguage: String?
}
