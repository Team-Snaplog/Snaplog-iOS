//
//  AuthRemote.swift
//  Data
//
//  Created by 강민성 on 11/3/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

import RxSwift

public protocol AuthRemoteProtocol {
    func login() -> Completable
    func refresh() -> Completable
    func logout() -> Completable
}

public final class AuthRemote: BaseRemote<AuthAPI>, AuthRemoteProtocol {
    public func login() -> Completable {
        return request(.login(code: "as")).asCompletable()
    }

    public func refresh() -> Completable {
        return request(.refresh).asCompletable()
    }

    public func logout() -> Completable {
        return request(.logout).asCompletable()
    }
}
