//
//  DynamicFramework.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 11/1/24.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers
import Foundation
import EnvironmentPlugin
import ConfigurationPlugin

let isCI = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1" ? true : false

extension Project{
    public static func dynamicFramework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        deploymentTarget: DeploymentTarget,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [
            .project(target: "ThirdPartyLib", path: Path("../ThirdPartyLib"))
        ]
    ) -> Project {
        return Project(
            name: name,
            packages: packages,
            settings: .settings(base: env.baseSetting, configurations: isCI ?
                                [
                                    .debug(name: .dev),
                                    .debug(name: .stage),
                                    .release(name: .prod)
                                ] :
                                    [
                                        .debug(name: .dev, xcconfig: .relativeToXCConfig(type: .dev, name: name)),
                                        .debug(name: .stage, xcconfig: .relativeToXCConfig(type: .stage, name: name)),
                                        .release(name: .prod, xcconfig: .relativeToXCConfig(type: .prod, name: name))
                                    ]),
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: .framework,
                    bundleId: "\(env.organizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    resources: resources,
                    dependencies: dependencies
                )
            ]
        )
    }
}
