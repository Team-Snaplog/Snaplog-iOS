//
//  ProjectEnvironment.swift
//  MyPlugin
//
//  Created by 강민성 on 8/25/24.
//

import ProjectDescription

public struct ProjectEnvironment {
    public let appName: String
    public let targetName: String
    public let targetTestName: String
    public let organizationName: String
    public let deploymentTarget: DeploymentTarget
    public let platform: Platform
    public let baseSetting: SettingsDictionary
}

public let env = ProjectEnvironment(
    appName: "Snaplog",
    targetName: "Snaplog",
    targetTestName: "Snaplog-Test",
    organizationName: "com.team.snaplog",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    platform: .iOS,
    baseSetting: ["OTHER_LDFLAGS": ["$(inherited) -Objc"]]
)
