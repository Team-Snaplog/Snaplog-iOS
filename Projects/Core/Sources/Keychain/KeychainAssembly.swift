//
//  KeychainAssembly.swift
//  Core
//
//  Created by 강민성 on 11/5/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Swinject

public final class KeychainAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(Keychain.self) { _ in
            KeychainImpl()
        }
    }
}
