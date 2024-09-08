//
//  SplashReactor.swift
//  Presentation
//
//  Created by 강민성 on 9/8/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

import RxSwift
import RxRelay
import ReactorKit
import RxFlow

public final class SplashReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    private let disposeBag: DisposeBag = DisposeBag()

    public typealias Action = NoAction

    init() {
        self.initialState = .init()
    }

    public enum Mutation {

    }

    public struct State {

    }

}
