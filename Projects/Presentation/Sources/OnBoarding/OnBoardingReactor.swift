//
//  OnBoardingReactor.swift
//  Presentation
//
//  Created by 강민성 on 9/10/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import Domain
import DesignSystem

import RxSwift
import RxRelay
import ReactorKit
import RxFlow
import UIKit

public final class OnBoardingReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    public let disposeBag: DisposeBag = DisposeBag()

    public init() {
        self.initialState = .init()
    }

    public enum Action {
        case viewWillAppear
        case didTapPreviousMonthButton
        case didTapNextMonthButton
    }

    public enum Mutation {
        case changeCurrentPage(Date)
        case setCurrentPage(Date)
        case setTopics([TopicEntity])
        case setPreviews([SnapEntity])
    }

    public struct State {
        var currentPage: Date = Date()
        var topics: [TopicEntity] = [
            TopicEntity(topicId: 1, topicTitle: "1번", topicEmoji: "🤬"),
            TopicEntity(topicId: 2, topicTitle: "2번", topicEmoji: "🤬"),
            TopicEntity(topicId: 3, topicTitle: "3번", topicEmoji: "🤬"),
            TopicEntity(topicId: 4, topicTitle: "4번", topicEmoji: "🤬"),
            TopicEntity(topicId: 5, topicTitle: "5번", topicEmoji: "🤬"),
            TopicEntity(topicId: 6, topicTitle: "6번", topicEmoji: "🤬"),
            TopicEntity(topicId: 7, topicTitle: "7번", topicEmoji: "🤬")
        ]
        var snaps: [SnapEntity] = [
            SnapEntity(snapId: 0, date: Date.now,
                       body: nil,
                       photos: [DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image],
                       topicId: 1),
            SnapEntity(snapId: 1, date: Date.now,
                       body: "블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라",
                       photos: [DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image],
                       topicId: 1),
            SnapEntity(snapId: 2, date: Date.now,
                       body: "블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라",
                       photos: [DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image],
                       topicId: 2),
            SnapEntity(snapId: 3, date: Date.now,
                       body: "블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라블라",
                       photos: [DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image,
                                DesignSystemAsset.Image.frame56.image],
                       topicId: 3)
        ]
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return Observable.concat(
                [.just(.setTopics(currentState.topics)),
                 .just(.setPreviews(currentState.snaps))
                ])
        case .didTapNextMonthButton:
            let currentDate = self.currentState.currentPage
            let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
            return .just(.changeCurrentPage(newDate))

        case .didTapPreviousMonthButton:
            let currentDate = self.currentState.currentPage
            let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
            return .just(.changeCurrentPage(newDate))
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case .setCurrentPage(let date):
            state.currentPage = date

        case .changeCurrentPage(let date):
            state.currentPage = date

        case .setTopics(let topics):
            var appendedTopics = topics
            appendedTopics.insert(TopicEntity(topicId: 0, topicTitle: "주제 추가", topicEmoji: "+"), at: 0)
            state.topics = appendedTopics

        case .setPreviews(let snaps):
            state.snaps = snaps
        }

        return state
    }
}
