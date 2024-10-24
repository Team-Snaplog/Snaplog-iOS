//
//  AddTopicFlow.swift
//  Flow
//
//  Created by 강민성 on 10/17/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import Presentation
import Core

import RxFlow
import Swinject

public final class AddTopicFlow: Flow {
    public let container: Container
    private let rootViewController: AddTopicViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = container.resolve(AddTopicViewController.self)!
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AddTopicStep else { return .none }

        switch step {
        case .addTopicViewIsRequired:
            return navigateToAddTopicViewController()

        case .popViewController:
            return popViewController()
        }
    }
}

public extension AddTopicFlow {
    func navigateToAddTopicViewController() -> FlowContributors {
//        let addTopicViewController = container.resolve(AddTopicViewController.self)!

//        self.rootViewController.pushViewController(addTopicViewController, animated: true)
//        pushViewControllers(addTopicViewController, animated: true)

        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: rootViewController.reactor!))
    }

    func popViewController() -> FlowContributors {
        let popView = self.rootViewController.navigationController?.viewControllers.first as? OnBoardingViewController
        self.rootViewController.navigationController?.popViewController(animated: true)

        return .none
    }
}
