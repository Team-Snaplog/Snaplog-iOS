//
//  PhotoCellReactor.swift
//  Presentation
//
//  Created by 강민성 on 10/30/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import UIKit
import Domain
import DesignSystem

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

public final class PhotoCellReactor: BaseReactor {
    
    public var steps = PublishRelay<Step>()
    public let initialState: State
    public let disposeBag: DisposeBag = DisposeBag()

    public init() {
        self.initialState = .init()
    }

    public enum Action {
        case didTapPhotos
    }

    public enum Mutation {
        case setSelected
    }

    public struct State {
        var photo: UIImage?
        var isSelected: Bool = false
    }

//    public func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//        case .didTapPhotos:
//            return .just(.setSelected)
//        }
//    }
//
//    public func reduce(state: State, mutation: Mutation) -> State {
//        var state = state
//
//        switch mutation {
//        case .setSelected:
//
//        }
//    }
}
