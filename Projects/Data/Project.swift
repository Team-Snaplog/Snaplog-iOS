//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 8/27/24.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Data",
    product: .staticFramework,
    targets: [],
    dependencies: [
        .Projects.domain,
        .Modules.appNetwork,
        .Modules.utility
    ],
    resources: .resources,
    coreDataModels: [CoreDataModel("Resources/LocalData.xcdatamodeld")]
)
