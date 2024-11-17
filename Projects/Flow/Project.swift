//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 8/25/24.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Flow",
    product: .staticLibrary,
    targets: [.unitTest],
    packages: [],
    dependencies: [
        .Projects.data,
        .Projects.presentation,
    ]
)
