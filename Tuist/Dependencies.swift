//
//  Dependencies.swift
//  Config
//
//  Created by 강민성 on 8/25/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    swiftPackageManager: .init(
        [
            .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .exact("6.6.0")),
            .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .upToNextMajor(from: "3.2.0")),
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.6.0")),
            .remote(url: "https://github.com/WenchaoD/FSCalendar.git", requirement: .upToNextMajor(from: "2.8.3")),
//            .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.19.1")),
            .remote(url: "https://github.com/guoyingtao/Mantis.git", requirement: .exact("2.18.0")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxFlow.git", requirement: .upToNextMajor(from: "2.10.0")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git", requirement: .upToNextMajor(from: "6.1.2")),
            .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.9.1")),
            .remote(url: "https://github.com/airbnb/lottie-spm.git", requirement: .upToNextMajor(from: "4.3.3")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxKeyboard.git", requirement: .exact("2.0.1")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .upToNextMajor(from: "5.0.0")),
            .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMajor(from: "4.0.4")),
            .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1")),
            .remote(url: "https://github.com/Team-Snaplog/Moya", requirement: .branch("master"))
        ],
        baseSettings: .settings(configurations: [
            .debug(name: .dev),
            .debug(name: .stage),
            .release(name: .prod)
        ]
        )
    ),
    platforms: [.iOS]
)
