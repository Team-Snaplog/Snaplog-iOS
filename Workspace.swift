//
//  Workspace.swift
//  Config
//
//  Created by 강민성 on 8/25/24.
//

@preconcurrency import ProjectDescription
import DependencyPlugin

let workspace = Workspace(name: "Snaplog", projects: ["Projects/**"])
