//
//  OnBoardingReactor.swift
//  Presentation
//
//  Created by 강민성 on 8/28/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

import RxSwift
import RxRelay
import ReactorKit
import RxFlow

public final class OnBoardingReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    private let disposeBag: DisposeBag = DisposeBag()

    init() {
        self.initialState = .init()
    }

    public enum Action {
        
    }

    public enum Mutation {
        
    }

    public struct State {
        
    }
}
