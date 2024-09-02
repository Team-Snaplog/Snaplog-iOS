//
//  OnBoardingStep.swift
//  Core
//
//  Created by 강민성 on 9/2/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

import RxFlow

public enum OnBoardingStep: Step {
    case onBoardingViewIsRequired
    case signInIsRequired
    case signUpIsRequired
    case homeViewIsRequired
}
