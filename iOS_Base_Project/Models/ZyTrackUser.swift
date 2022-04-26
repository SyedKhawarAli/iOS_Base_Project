//
//  ZyTrackUser.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 3/1/21.
//

import ObjectMapper

class ZyTrackUser: Mappable {
    var active: Bool?
    var appVersion: String?
    var name: String?
    var appPlatform: String?
    var deviceToken: String?
    var id: Int?
    var email: String?
    var uid: String?
    var accessToken: String?
    var client: String?

    required init?(map _: Map) {}

    func mapping(map: Map) {
        active <- map["active?"]
        appVersion <- map["app_version"]
        name <- map["full_name"]
        appPlatform <- map["app_platform"]
        deviceToken <- map["device_token"]
        id <- map["id"]
        email <- map["email"]
        uid <- map["uid"]
        if Environment.current == .production || Environment.current == .development {
            accessToken <- map["access-token"]
            client <- map["client"]
        } else {
            accessToken <- map["Access-Token"]
            client <- map["Client"]
        }
    }
}
