//
//  CompleteAddTopicStep.swift
//  Core
//
//  Created by 강민성 on 10/29/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

import RxFlow

public enum CompleteAddTopicStep: Step {
    case completeAddTopicViewisRequired(String, String)
    case addPhotosViewIsRequired
    case onBoardingViewIsRequired
}
