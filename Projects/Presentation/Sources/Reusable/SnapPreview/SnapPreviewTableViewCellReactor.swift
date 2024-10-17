//
//  SnapPreviewTableViewCellReactor.swift
//  Presentation
//
//  Created by 강민성 on 10/7/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import UIKit
import Domain

import RxSwift
import RxCocoa
import RxRelay
import ReactorKit
import RxFlow

public final class SnapPreviewTableViewCellReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    public let disposeBag: DisposeBag = DisposeBag()

    public init(item: SnapEntity) {
        let imageReactors = item.photos.map { SnapPreviewImageCollectionViewCellReactor(item: $0) }
        self.initialState = State(date: item.date, body: item.body, photos: item.photos, imageReactors: imageReactors)
    }

    public enum Action {
        case viewWillAppear
        case didTapPreview
    }

    public enum Mutation {
        case setPhotos([UIImage])
        case setPreview
    }

    public struct State {
        var date: Date
        var body: String?
        var photos: [UIImage] = []
        var imageReactors: [SnapPreviewImageCollectionViewCellReactor]
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return .just(.setPhotos(currentState.photos))

        case .didTapPreview:
            return .empty()
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case .setPhotos(let photos):
            state.photos = photos

        case .setPreview:
            break
        }

        return state
    }
}
