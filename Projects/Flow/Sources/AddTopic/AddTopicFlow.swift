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

        case let .completeAddTopicViewisRequired(title, emoji):
            return .end(forwardToParentFlowWithStep: OnBoardingStep.completeAddTopicViewIsRequired(title, emoji))
//            return navigateToCompleteAddTopicViewController(title: title, emoji: emoji)

        case .popViewController:
            return popViewController()

        case .presentDeniedAlert(target: let target):
            return .none

        case .addPhotosViewIsRequired:
//            return navigateToAddPhotosViewController()
            return .none

        case .onBoardingViewIsRequired:
            return .end(forwardToParentFlowWithStep: OnBoardingStep.onBoardingViewIsRequired)
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

//    func navigateToCompleteAddTopicViewController(title: String, emoji: String) -> FlowContributors {
//        guard let completeAddTopicViewController = container.resolve(
//            CompleteAddTopicViewController.self,
//            arguments: title, emoji) else {
//            return .none
//        }
//        let completeAddTopicReactor = completeAddTopicViewController.reactor
//        completeAddTopicViewController.modalPresentationStyle = .overFullScreen
//        self.rootViewController.present(completeAddTopicViewController, animated: true)
//        let completeAddTopicFlow = CompleteAddTopicFlow(container: container)
//
//        Flows.use(completeAddTopicFlow, when: .created) { (root) in
//            let view = root as? CompleteAddTopicViewController
//            self.rootViewController.setViewC
//        }
//
//        return .one(flowContributor: .contribute(withNextPresentable: completeAddTopicViewController, withNextStepper: completeAddTopicReactor!))
//    }

    func popViewController() -> FlowContributors {
        let popView = self.rootViewController.navigationController?.viewControllers.first as? OnBoardingViewController
        self.rootViewController.navigationController?.popViewController(animated: true)

        return .none
    }

//    func navigateToAddPhotosViewController() -> FlowContributors {
//        let addPhotosFlow = AddPhotosFlow(container: container)
//
//        Flows.use(addPhotosFlow, when: .created) { (root) in
//            let view = root as? AddPhotosViewController
//            let vc = AddTopicViewController()
//        }
//        return .one(flowContributor: .contribute(withNextPresentable: addPhotosFlow, withNextStepper: OneStepper(withSingleStep: AddPhotosStep.addPhotosViewIsRequired)))
//    }
}
