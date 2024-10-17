//
//  TopicCollectionViewCellReactor.swift
//  Presentation
//
//  Created by 강민성 on 9/22/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import UIKit
import Domain

import RxSwift
import RxRelay
import RxFlow
import RxCocoa
import ReactorKit

public final class TopicCollectionViewCellReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    public let disposeBag: DisposeBag = DisposeBag()

    let indexPath: IndexPath

    public init(item: TopicEntity, indexPath: IndexPath) {
        self.initialState = State(emoji: item.topicEmoji, title: item.topicTitle)
        self.indexPath = indexPath
//        self.initialState = State(emoji: "🥐", title: "대동빵지도")
    }

    public enum Action {
        case didTapAddTopicCell
    }

    public enum Mutation {
        case setEmoji
        case setTitle
        case setTapped
    }

    public struct State {
        var emoji: String = ""
        var title: String = ""
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapAddTopicCell:
            if indexPath.item == 0 {
                print("TAP FIRST")
                return .just(.setTapped)
            }
            else {
                print("TAP ELSE")
                return .just(.setTapped)
            }
        }
    }
}
