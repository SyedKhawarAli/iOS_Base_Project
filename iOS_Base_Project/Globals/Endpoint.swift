//
//  Endpoint.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/19/21.
//

import Foundation

enum Endpoint {
    // MARK: - Auth EndPoints

    static var login: URL? {
        URL(string: "users/sign_in.json", relativeTo: Environment.baseUrl)
    }

    static var logout: URL? {
        URL(string: "users/sign_out.json", relativeTo: Environment.baseUrl)
    }

    static var forgotPassword: URL? {
        URL(string: "users/password.json", relativeTo: Environment.baseUrl)
    }

    static var deleteUser: (Int) -> URL? = {
        URL(string: "users/\($0)", relativeTo: Environment.baseUrl)
    }
}
