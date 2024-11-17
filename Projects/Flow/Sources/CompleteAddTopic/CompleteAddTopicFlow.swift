//
//  CompleteAddTopicFlow.swift
//  Flow
//
//  Created by 강민성 on 10/29/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import Presentation
import Core

import RxFlow
import Swinject

public final class CompleteAddTopicFlow: Flow {
    public let container: Container
    private let rootViewController = NavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
//        self.rootViewController = container.resolve(AddTopicViewController.self)!
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? CompleteAddTopicStep else { return .none }

        switch step {
        case let .completeAddTopicViewisRequired(title, emoji):
            return navigateToCompleteAddTopicViewController(title: title, emoji: emoji)

        case .addPhotosViewIsRequired:
            return navigateToAddPhotosViewController()

        case .onBoardingViewIsRequired:
            return .end(forwardToParentFlowWithStep: AppStep.onBoardingViewIsRequired)
        }
    }
}

public extension CompleteAddTopicFlow {
    func navigateToCompleteAddTopicViewController(title: String, emoji: String) -> FlowContributors {
        guard let completeAddTopicViewController = container.resolve(
            CompleteAddTopicViewController.self,
            arguments: title, emoji) else {
            return .none
        }
        let completeAddTopicReactor = completeAddTopicViewController.reactor
        completeAddTopicViewController.modalPresentationStyle = .overFullScreen
        self.rootViewController.setViewControllers([completeAddTopicViewController], animated: true)

        return .one(flowContributor: .contribute(withNextPresentable: completeAddTopicViewController, withNextStepper: completeAddTopicReactor!))
    }

    func popViewController() -> FlowContributors {
        let popView = self.rootViewController.navigationController?.viewControllers.first as? OnBoardingViewController
        self.rootViewController.navigationController?.popViewController(animated: true)

        return .none
    }

    func navigateToAddPhotosViewController() -> FlowContributors {
        let addPhotosFlow = AddPhotosFlow(container: container)

        Flows.use(addPhotosFlow, when: .created) { (root) in
            print(root)
            let view = root as? AddPhotosViewController
            self.rootViewController.pushViewController(view!, animated: true)
        }
        return .one(flowContributor: .contribute(withNextPresentable: addPhotosFlow, withNextStepper: OneStepper(withSingleStep: AddPhotosStep.addPhotosViewIsRequired)))
    }
}
