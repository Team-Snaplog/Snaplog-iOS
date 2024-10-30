//
//  AddPhotosReactor.swift
//  Presentation
//
//  Created by 강민성 on 10/29/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Domain
import Core

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

public final class AddPhotosReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    private let disposeBag: DisposeBag = DisposeBag()

    public enum Action {
        case didTapPhoto(IndexPath)
    }

    public enum Mutation {
        case setPhotoSelected(IndexPath)
    }

    public struct State {
        var isSelected: Bool = false
    }

    public init() {
        self.initialState = .init()
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTapPhoto(indexPath):
            if indexPath.item != 0 {
                return .just(.setPhotoSelected(indexPath))
            } else {
                return .empty()
            }
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case let .setPhotoSelected(indexPath):
            state.isSelected = true
        }

        return state
    }
}
