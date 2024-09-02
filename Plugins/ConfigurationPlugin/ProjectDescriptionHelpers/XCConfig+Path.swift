//
//  XCConfig+Path.swift
//  DependencyPlugin
//
//  Created by 강민성 on 8/27/24.
//

import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToXCConfig(type: ProjectDeployTarget, name: String) -> Self {
         .relativeToRoot("XCConfig/\(name)/\(type.rawValue).xcconfig")
    }
}
