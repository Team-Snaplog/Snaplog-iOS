//
//  AddPhotosReactor.swift
//  Presentation
//
//  Created by 강민성 on 10/29/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import UIKit
import Domain
import Core
import Data

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

public final class AddPhotosReactor: BaseReactor {

    public var steps = PublishRelay<Step>()
    public let initialState: State
    private let disposeBag: DisposeBag = DisposeBag()

    public enum Action {
        case viewWillAppear
        case selectImage(UIImage)
        case deSelectImage(UIImage)
        case didSelectTopic(TopicEntity)
        case didTapAddSnapButton
        case didDateSelected(Date)
    }

    public enum Mutation {
        case setPhotoSelected(UIImage)
        case setPhotoDeSelected(UIImage)
        case setTopicSelected(TopicEntity)
        case setTopics
        case setDate(Date)
    }

    public struct State {
        var isPhotoSelected: Bool = false
        var topics: [TopicEntity] = []
        var photos: [UIImage] = []
        var selectedTopic: TopicEntity?
        var isTopicSelected: Bool = false
        var isAddSnapEnabled: Bool = false
        var date: Date = Date.now
    }

    public init() {
        self.initialState = .init()
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return .just(.setTopics)

        case let .selectImage(image):
            return .just(.setPhotoSelected(image))

        case let .deSelectImage(image):
            return .just(.setPhotoDeSelected(image))

        case let .didSelectTopic(topic):
            return .just(.setTopicSelected(topic))

        case .didTapAddSnapButton:
            let topics = CoreDataManager.shared.fetchAllTopics()
            let selectedTopic = topics[currentState.selectedTopic!.topicId - 1]
            let newSnap = CoreDataManager.shared.createSnap(
                topic: selectedTopic,
                date: currentState.date,
                body: "",
                images: currentState.photos)
            steps.accept(AddPhotosStep.mainViewIsRequired)
            return .empty()

        case let .didDateSelected(date):
            return .just(.setDate(date))
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case let .setPhotoSelected(image):
            state.photos.append(image)

        case let .setPhotoDeSelected(image):
            state.photos.removeAll { $0 == image }

        case let .setTopicSelected(topic):
            state.selectedTopic = topic
            state.isTopicSelected = true

        case .setTopics:
            let localTopics = CoreDataManager.shared.fetchAllTopics()
            if localTopics.count == 0 {
                fatalError("생성된 주제 없음")
            } else {
                var topics: [TopicEntity] = localTopics.map {
                    TopicEntity(topicId: Int($0.id), topicTitle: $0.title!, topicEmoji: $0.emoji!)
                }
                state.topics = topics
            }

        case let .setDate(date):
            state.date = date
        }

        state.isAddSnapEnabled = !state.photos.isEmpty && state.isTopicSelected

        return state
    }
}
