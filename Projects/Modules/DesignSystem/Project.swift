//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 8/27/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "DesignSystem",
    product: .framework,
    targets: [.demo],
    dependencies: [
        .Modules.utility
    ],
    resources: .resources,
    resourceSynthesizers: .default + [
        .custom(name: "Lottie", parser: .json, extensions: ["json"])
    ]
)
