//
//  HomeFlow.swift
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

public final class HomeFlow: Flow {
    public let container: Container
    private let rootViewController = NavigationController()
    public var root: Presentable {
        return rootViewController
    }
    
    public init(container: Container) {
        self.container = container
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? HomeStep else { return .none }
        
        switch step {
        case .homeViewIsRequired:
            return self.navigateToHomeViewController()
        }
    }
}

extension HomeFlow {
    func navigateToHomeViewController() -> FlowContributors {
        let homeViewController = container.resolve(HomeViewController.self)!
        
        self.rootViewController.setViewControllers([homeViewController], animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: homeViewController, withNextStepper: homeViewController.reactor))
    }
}
