//
//  TokenDTO.swift
//  AppNetwork
//
//  Created by 강민성 on 11/5/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

public struct TokenDTO: Decodable {
    public let accessToken: String
    public let refreshToken: String
    public let accessTokenExpireDate: String
    public let refreshTokenExpireDate: String
}
