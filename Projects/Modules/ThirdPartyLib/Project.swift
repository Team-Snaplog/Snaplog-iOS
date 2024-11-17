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
    name: "ThirdPartyLib",
    product: .staticFramework,
    targets: [],
    packages: [
//               .Then,
//               .Firebase,
//               .GoogleSignIn,
               /*.KeychainSwift*/],
    dependencies: [
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.RxSwift,
        .SPM.SnapKit,
        .SPM.Alamofire,
        .SPM.Moya,
        .SPM.RxMoya,
        .SPM.kingfisher,
        .SPM.ReactorKit,
        .SPM.RxGesture,
        .SPM.Swinject,
        .SPM.RxKeyboard
    ]
)
