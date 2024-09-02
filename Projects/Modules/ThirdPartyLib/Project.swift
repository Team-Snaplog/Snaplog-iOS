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
    name: "ThirdPartyLib",
    product: .staticFramework,
    targets: [],
    dependencies: [
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.RxSwift,
        .SPM.SnapKit,
        .SPM.Moya,
        .SPM.RxMoya,
        .SPM.Lottie,
        .SPM.kingfisher,
        .SPM.ReactorKit,
        .SPM.RxGesture,
        .SPM.Swinject,
        .SPM.RxKeyboard,
    ]
)
