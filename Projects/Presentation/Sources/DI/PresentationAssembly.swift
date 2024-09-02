//
//  PresentationAssembly.swift
//  Presentation
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Core
import Domain

import Swinject

public final class PresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(HomeReactor.self) { resolver in
            HomeReactor()
        }
        
        container.register(HomeViewController.self) { resolver in
            HomeViewController(resolver.resolve(HomeReactor.self)!)
        }
        
        container.register(OnBoardingReactor.self) { resolver in
            OnBoardingReactor()
        }
        
        container.register(OnBoardingViewController.self) { resolver in
            OnBoardingViewController(resolver.resolve(OnBoardingReactor.self)!)
        }
    }
}
