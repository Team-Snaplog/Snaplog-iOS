//
//  AppFlow.swift
//  Flow
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import Core

import RxSwift
import RxFlow
import Swinject

public final class AppFlow: Flow {
    public let window: UIWindow
    public let container: Container
    public var root: Presentable {
        return self.window
    }
    
    public init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .onBoardingViewIsRequired:
            return self.navigateToOnBoardingViewController()

        case .homeViewIsRequired:
            return self.navigateToHomeViewController()
        }
    }
}

public extension AppFlow {
    func navigateToOnBoardingViewController() -> FlowContributors {
        let onBoardingFlow = OnBoardingFlow(container: container)
        
        Flows.use(onBoardingFlow, when: .created) { (root) in
            self.window.rootViewController = root
        }
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: onBoardingFlow,
                withNextStepper: OneStepper(
                    withSingleStep: OnBoardingStep.onBoardingViewIsRequired)))
    }
    
    func navigateToHomeViewController() -> FlowContributors {
        let homeFlow = HomeFlow(container: container)
        
        Flows.use(homeFlow, when: .created) { (root) in
            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve) {
                self.window.rootViewController = root
            }
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: HomeStep.homeViewIsRequired)))
    }
}
