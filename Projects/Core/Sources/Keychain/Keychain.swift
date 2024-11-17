//
//  JWTStore.swift
//  Core
//
//  Created by 강민성 on 11/5/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

public enum KeychainType: String {
    case accessToken = "ACCESS-TOKEN"
    case refreshToken = "REFRESH-TOKEN"
    case accessTokenExpriedAt = "ACCESS-EXPIRED-AT"
    case refreshTokenExpiredAt = "REFRESH-EXPIRED-AT"
}

public protocol Keychain {
    func save(type: KeychainType, value: String)
    func load(type: KeychainType) -> String
    func delete(type: KeychainType)
}
