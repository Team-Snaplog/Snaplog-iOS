//
//  UserLocal.swift
//  Data
//
//  Created by 강민성 on 11/5/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import RxSwift
import Core
import Domain

protocol UserLocalDataSource {
    func clearAllTokens()
}

public struct UserLocalDataSourceImpl: UserLocalDataSource {
    private let keychain: any Keychain

    public init(keychain: any Keychain) {
        self.keychain = keychain
    }

    public func clearAllTokens() {
        keychain.delete(type: .accessToken)
        keychain.delete(type: .accessTokenExpriedAt)
        keychain.delete(type: .refreshToken)
        keychain.delete(type: .refreshTokenExpiredAt)
    }
}
