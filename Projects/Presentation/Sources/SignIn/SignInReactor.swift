//
//  SignInReactor.swift
//  Presentation
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Core

import RxSwift
import RxRelay
import ReactorKit
import RxFlow

public final class SignInReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    private let disposeBag: DisposeBag = DisposeBag()

    public init() {
        self.initialState = .init()
    }

    public enum Action {
        case didTapStartWithGuestButton
    }

    public enum Mutation {
        
    }

    public struct State {
        
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapStartWithGuestButton:
            steps.accept(SignInStep.onBoardingViewIsRequired)
            return .empty()
        }
    }
}
