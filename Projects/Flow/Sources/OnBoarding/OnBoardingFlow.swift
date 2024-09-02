//
//  OnBoardingFlow.swift
//  Flow
//
//  Created by 강민성 on 9/2/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import Presentation
import Core

import RxFlow
import Swinject

public final class OnBoardingFlow: Flow {
    public let container: Container
    private let rootViewController = NavigationController()
    public var root: Presentable {
        return rootViewController
    }
    
    public init(container: Container) {
        self.container = container
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? OnBoardingStep else { return .none }
        
        switch step {
        case .onBoardingViewIsRequired:
            return navigateToOnBoardingViewController()
            
        default:
            return .none
        }
    }
}

public extension OnBoardingFlow {
    func navigateToOnBoardingViewController() -> FlowContributors {
        let onBoardingViewController = container.resolve(OnBoardingViewController.self)!
        
        self.rootViewController.setViewControllers([onBoardingViewController], animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: onBoardingViewController, withNextStepper: onBoardingViewController.reactor))
    }
}
