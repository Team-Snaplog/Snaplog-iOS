//
//  Configuration+Ext.swift
//  DependencyPlugin
//
//  Created by 강민성 on 8/27/24.
//

import ProjectDescription

public extension ConfigurationName {
    static var dev: ConfigurationName { configuration(ProjectDeployTarget.dev.rawValue) }
    static var stage: ConfigurationName { configuration(ProjectDeployTarget.stage.rawValue) }
    static var prod: ConfigurationName { configuration(ProjectDeployTarget.prod.rawValue) }
}
