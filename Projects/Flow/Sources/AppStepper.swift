//
//  AppStepper.swift
//  Flow
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Core

import RxSwift
import RxRelay
import RxFlow

public final class AppStepper: Stepper {
    public let steps = PublishRelay<Step>()
    private let dispoeBag: DisposeBag = DisposeBag()
    
    public init() {}
    
    public var initialStep: Step {
        return AppStep.onBoardingViewIsRequired
    }
}
