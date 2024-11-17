//
//  JWTPlugin.swift
//  AppNetwork
//
//  Created by 강민성 on 11/5/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Core
import Moya

public enum JWTTokenType: String {
    case none = ""
    case accessToken = "Authorization"
    case refreshToken = "Refresh-Token"
}

public protocol JWTTokenAuthorizable {
    var jwtTokenType: JWTTokenType? { get }
}

public final class JWTPlugin: PluginType {

    private let keychain: any Keychain

    public init(keychain: any Keychain) {
        self.keychain = keychain
    }

    public func prepare(_ request: URLRequest, target: any TargetType) -> URLRequest {
        guard let jwtTokenType = (target as? JWTTokenAuthorizable)?.jwtTokenType,
              jwtTokenType != .none
        else { return request }

        var request = request

        let token = "\(getToken(type: jwtTokenType == .accessToken ? .accessToken : .refreshToken))"
        request.addValue(token, forHTTPHeaderField: jwtTokenType.rawValue)
        return request
    }

    public func didReceive(_ result: Result<Response, MoyaError>, target: any TargetType) {
        switch result {
        case let .success(result):
            if let newToken = try? result.map(TokenDTO.self) {
                self.setTokens(token: newToken)
            }
        default:
            break
        }
    }
}

extension JWTPlugin {
    func getToken(type: KeychainType) -> String {
        switch type {
        case .accessToken:
            return "Bearer \(keychain.load(type: .accessToken))"

        case .accessTokenExpriedAt:
            return keychain.load(type: .accessTokenExpriedAt)

        case .refreshToken:
            return keychain.load(type: .refreshToken)

        case .refreshTokenExpiredAt:
            return keychain.load(type: .refreshTokenExpiredAt)
        }
    }

    func setTokens(token: TokenDTO) {
        keychain.save(type: .accessToken, value: token.accessToken)
        keychain.save(type: .accessTokenExpriedAt, value: token.accessTokenExpireDate   )
        keychain.save(type: .refreshToken, value: token.refreshToken)
        keychain.save(type: .refreshTokenExpiredAt, value: token.refreshTokenExpireDate)
    }
}
