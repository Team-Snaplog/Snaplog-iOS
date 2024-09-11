//
//  SignInFlow.swift
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

public final class SignInFlow: Flow {
    public let container: Container
    private let rootViewController = NavigationController()
    public var root: Presentable {
        return rootViewController
    }
    
    public init(container: Container) {
        self.container = container
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SignInStep else { return .none }
        
        switch step {
        case .signInViewIsRequired:
            return navigateToSignInViewController()
            
        default:
            return .none
        }
    }
}

public extension SignInFlow {
    func navigateToSignInViewController() -> FlowContributors {
        let signInViewController = container.resolve(SignInViewController.self)!
        
        self.rootViewController.setViewControllers([signInViewController], animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: signInViewController, withNextStepper: signInViewController.reactor))
    }
}
