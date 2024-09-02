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
    name: "Presentation",
    product: .staticLibrary,
    targets: [.unitTest],
    dependencies: [
        .Projects.domain,
        .Modules.designSystem
    ]
)
