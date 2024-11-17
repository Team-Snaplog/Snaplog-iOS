//
//  SelectTopicCollectionViewCellReactor.swift
//  Presentation
//
//  Created by 강민성 on 11/12/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Utility
import CoreData
import Data
import Domain

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

public final class SelectTopicCollectionViewCellReactor: BaseReactor {

    public let steps = PublishRelay<Step>()
    public let initialState: State
    public let disposeBag: DisposeBag = DisposeBag()

    public init(item: TopicEntity) {
        self.initialState = State(topic: item, title: item.topicTitle, emoji: item.topicEmoji, id: item.topicId)
    }

    public enum Action {
        case didSelectTopic
    }

    public enum Mutation {
        case setSelected
    }

    public struct State {
        var topic: TopicEntity
        var title: String = ""
        var emoji: String = ""
        var id: Int?
    }
}


