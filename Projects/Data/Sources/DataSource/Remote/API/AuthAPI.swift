//
//  AuthAPI.swift
//  Data
//
//  Created by 강민성 on 11/3/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Domain
import AppNetwork

import Moya

public enum AuthAPI {
    case login(code: String)
    case refresh
    case logout
}

extension AuthAPI: BaseAPI {
    
    public typealias ErrorType = BaseError

    public var domain: BaseDomain {
        return .auth
    }

    public var urlPath: String {
        switch self {
        case .login, .refresh, .logout:
            return ""
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post

        case .refresh:
            return .patch

        case .logout:
            return .delete
        }
    }

    public var task: Task {
        switch self {
        case let .login(request):
            return .requestParameters(parameters: [
                :
            ], encoding: JSONEncoding.default)

        case .refresh:
            return .requestParameters(parameters: [:], encoding: JSONEncoding.default)

        case .logout:
            return .requestPlain
        }
    }

    public var jwtTokenType: JWTTokenType? {
        switch self {
        case .login:
            return JWTTokenType.none

        case .refresh:
            return .refreshToken

        case .logout:
            return .accessToken
        }
    }

    public var errorMapper: [Int: BaseError]? {
        switch self {
        case .login:
            return [
                500: .serverError
            ]

        case .refresh:
            return [
                500: .serverError
            ]

        case .logout:
            return [
                500: .serverError
            ]
        }
    }
}
