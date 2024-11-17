//
//  DataAssembly.swift
//  Data
//
//  Created by 강민성 on 11/10/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Core
import Domain

import Swinject

public final class DataAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        
        container.register(CoreDataManager.self) { resolver in
            CoreDataManager.shared
        }
    }

}
