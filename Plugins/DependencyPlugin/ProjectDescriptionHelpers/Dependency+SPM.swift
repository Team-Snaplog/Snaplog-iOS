//
//  Dependency+SPM.swift
//  MyPlugin
//
//  Created by 강민성 on 8/25/24.
//

import ProjectDescription

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
//    static let Firebase = TargetDependency.external(name: "Firebase")
    static let Moya = TargetDependency.external(name: "Moya")
    static let RxMoya = TargetDependency.external(name: "RxMoya")
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let kingfisher = TargetDependency.external(name: "Kingfisher")
    static let RxGesture = TargetDependency.external(name: "RxGesture")
    static let FSCalendar = TargetDependency.external(name: "FSCalendar")
    static let Mantis = TargetDependency.external(name: "Mantis")
    static let RxDataSources = TargetDependency.external(name: "RxDataSources")
    static let RxKeyboard = TargetDependency.external(name: "RxKeyboard")
    static let Swinject = TargetDependency.external(name: "Swinject")
}
