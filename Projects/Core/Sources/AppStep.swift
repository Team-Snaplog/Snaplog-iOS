//
//  AppStep.swift
//  Core
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import RxFlow

public enum AppStep: Step {
    case onBoardingViewIsRequired
    case homeViewIsRequired
}
