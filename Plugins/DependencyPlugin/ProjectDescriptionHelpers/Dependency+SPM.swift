//
//  Dependency+SPM.swift
//  MyPlugin
//
//  Created by 강민성 on 8/25/24.
//

@preconcurrency import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let ReactorKit = TargetDependency.external(name: "ReactorKit")
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let RxFlow = TargetDependency.external(name: "RxFlow")
    static let Alamofire = TargetDependency.external(name: "Alamofire")
    static let Moya = TargetDependency.external(name: "Moya")
    static let RxMoya = TargetDependency.external(name: "RxMoya")
    static let kingfisher = TargetDependency.external(name: "Kingfisher")
    static let RxGesture = TargetDependency.external(name: "RxGesture")
    static let Mantis = TargetDependency.external(name: "Mantis")
    static let RxDataSources = TargetDependency.external(name: "RxDataSources")
    static let RxKeyboard = TargetDependency.external(name: "RxKeyboard")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Then = TargetDependency.package(product: "Then")
    static let FirebaseCore = TargetDependency.package(product: "FirebaseCore")
    static let FirebaseAuth = TargetDependency.package(product: "FirebaseAuth")
    static let GoogleSignIn = TargetDependency.package(product: "GoogleSignIn")
    static let KeychainSwift = TargetDependency.package(product: "KeychainSwift")
}

public extension Package {
//    static let Then = Package.remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0"))
//    static let GoogleSignIn = Package.remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .upToNextMajor(from: "8.0.0"))
//    static let KeychainSwift = Package.remote(url: "https://github.com/evgenyneu/keychain-swift.git", requirement: .upToNextMajor(from: "24.0.0"))
//    static let Firebase = Package.remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "11.4.0"))
}
