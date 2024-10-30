//
//  AddPhotosFlow.swift
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

public final class AddPhotosFlow: Flow {
    public let container: Container
    private let rootViewController: AddPhotosViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = container.resolve(AddPhotosViewController.self)!
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AddPhotosStep else { return .none }

        switch step {
        case .addPhotosViewIsRequired:
            return navigateToAddPhotosViewController()
        }
    }
}

public extension AddPhotosFlow {
    func navigateToAddPhotosViewController() -> FlowContributors {
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: rootViewController.reactor!))
    }
}
