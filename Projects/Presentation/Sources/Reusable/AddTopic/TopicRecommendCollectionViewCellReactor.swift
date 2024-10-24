//
//  TopicRecommendCollectionViewCellReactor.swift
//  Presentation
//
//  Created by 강민성 on 10/19/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Domain
import DesignSystem

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

public final class TopicRecommendCollectionViewCellReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    public let disposeBag: DisposeBag = DisposeBag()

    public init(item: RandomTopicEntity) {
        self.initialState = State(emoji: item.topicEmoji, title: item.topicTitle)
    }

    public enum Action {
        case didTapRecommendTopic
    }

    public enum Mutation {
        case setTopic
    }

    public struct State {
        var emoji: String
        var title: String
    }

}
