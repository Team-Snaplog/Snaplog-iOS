//
//  ProjectDeployTarget.swift
//  DependencyPlugin
//
//  Created by 강민성 on 8/27/24.
//

import Foundation
import ProjectDescription

public enum ProjectDeployTarget: String {
    case dev = "DEV"
    case stage = "STAGE"
    case prod = "PROD"

    public var configurationName: ConfigurationName {
        ConfigurationName.configuration(self.rawValue)
    }
}
