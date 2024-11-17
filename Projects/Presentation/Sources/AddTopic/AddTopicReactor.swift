//
//  AddTopicReactor.swift
//  Presentation
//
//  Created by 강민성 on 10/17/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import DesignSystem
import Domain
import Utility
import Core
import Data
import CoreData
import RxSwift
import RxRelay
import RxFlow
import ReactorKit

public final class AddTopicReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    private let disposeBag: DisposeBag = DisposeBag()

    private var randomEmojiArr = ["❗️", "🌚", "😗", "🎽", "🚯", "🐶", "🛹", "🏋️‍♂️", "🎣", "🎙️"]

    public init() {
        self.initialState = State(recommendTopics: [
            RandomTopicEntity(topicTitle: "식물 성장기", topicEmoji: "🪴"),
            RandomTopicEntity(topicTitle: "운동 일지", topicEmoji: "💪"),
            RandomTopicEntity(topicTitle: "식단 일지", topicEmoji: "🥗"),
            RandomTopicEntity(topicTitle: "맛집 탐방기", topicEmoji: "🍴"),
            RandomTopicEntity(topicTitle: "영화 리뷰", topicEmoji: "🎥"),
            RandomTopicEntity(topicTitle: "스터디 기록", topicEmoji: "📝"),
            RandomTopicEntity(topicTitle: "반려동물 기록", topicEmoji: "🐶"),
            RandomTopicEntity(topicTitle: "지출 일기", topicEmoji: "💵"),
            RandomTopicEntity(topicTitle: "사진 일기", topicEmoji: "🖼️"),
            RandomTopicEntity(topicTitle: "카페 탐방기", topicEmoji: "☕️"),
            RandomTopicEntity(topicTitle: "여행 기록", topicEmoji: "🧭"),
            RandomTopicEntity(topicTitle: "위스키 기록", topicEmoji: "🥃")
        ])
    }

    public enum Action {
        case viewWillAppear
        case didWriteEmoji(String)
        case didWriteTitle(String)
        case didTapRecommendTopic(String, String)
        case didTapAddTopicButton
        case didTapBackButton
    }

    public enum Mutation {
        case setEmoji(String)
        case setTitle(String)
        case setTitleCount(Int)
        case setRecommendTopic
        case setEmojiError(Bool)
        case setEmptyEmojiError(Bool)
        case setAddTopicEnable
    }

    public struct State {
        var recommendTopics: [RandomTopicEntity]
        var emoji: String? = ""
        var title: String? = ""
        var titleCount: Int? = 0
        var emojiError: Bool = false
        var emptyEmojiError: Bool = false
        var isAddTopicEnable: Bool = false
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return .just(.setEmoji(self.randomEmojiArr.randomElement()!))

        case .didWriteEmoji(let text):
            if text.count == 1 {
                if text.isSingleEmoji {
                    return .concat([.just(.setEmoji(text)),
                                    .just(.setEmojiError(false)),
                                    .just(.setEmptyEmojiError(false)),
                                    .just(.setAddTopicEnable)
                    ])
                } else {
                    return .concat([.just(.setEmojiError(true)), .just(.setAddTopicEnable)])
                }
            } else {
                return .concat([.just(.setEmptyEmojiError(true)), .just(.setAddTopicEnable)])
            }

        case .didWriteTitle(let text):
            return .concat(
                [.just(.setTitle(text)),
                 .just(.setTitleCount(text.count)),
                 .just(.setAddTopicEnable)
                ])

        case .didTapRecommendTopic(let emoji, let title):
            return .concat([.just(.setEmoji(emoji)), .just(.setTitle(title)), .just(.setTitleCount(title.count)), .just(.setAddTopicEnable)])

        case .didTapBackButton:
            steps.accept(AddTopicStep.popViewController)
            return .empty()

        case .didTapAddTopicButton:
            let newTopic = CoreDataManager.shared.createTopic(emoji: currentState.emoji!, title: currentState.title!)
            if let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
                print("로컬 저장소: \(documentsDirectoryURL)")
            }
            steps.accept(AddTopicStep.completeAddTopicViewisRequired(currentState.title!, currentState.emoji!))
            return .empty()
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case .setTitle(let title):
            state.title = title

        case .setTitleCount(let count):
            state.titleCount = count

        case .setEmojiError(let bool):
            state.emojiError = bool

        case .setEmoji(let emoji):
            state.emoji = emoji

        case .setEmptyEmojiError(let bool):
            state.emptyEmojiError = bool

        case .setAddTopicEnable:
            if currentState.emptyEmojiError == false &&
                currentState.emojiError == false &&
                currentState.titleCount != 0 {
                state.isAddTopicEnable = true
            } else {
                state.isAddTopicEnable = false
            }

        default:
            break
        }

        return state
    }
}
