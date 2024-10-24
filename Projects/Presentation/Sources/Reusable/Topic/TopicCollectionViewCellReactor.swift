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
import Core

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
    }

    public typealias Action = NoAction

    public enum Mutation {
        case setEmoji
        case setTitle
        case setTapped
    }

    public struct State {
        var emoji: String = ""
        var title: String = ""
    }
}
