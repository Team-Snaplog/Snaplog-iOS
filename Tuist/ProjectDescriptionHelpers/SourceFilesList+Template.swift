//
//  SourceFilesList+Template.swift
//  Config
//
//  Created by 강민성 on 8/25/24.
//

@preconcurrency import ProjectDescription

public extension SourceFilesList {
    static let demoSources: SourceFilesList = "Demo/Sources/**"
    static let sources: SourceFilesList = "Sources/**"
    static let unitTests: SourceFilesList = "Tests/**"
}
