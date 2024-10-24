//
//  AddTopicStep.swift
//  Core
//
//  Created by 강민성 on 10/17/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

import RxFlow

public enum AddTopicStep: Step {
    case addTopicViewIsRequired
    case popViewController
}
