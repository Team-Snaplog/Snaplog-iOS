//
//  RandomTopicEntity.swift
//  Domain
//
//  Created by 강민성 on 10/21/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

public struct RandomTopicEntity: Equatable, Hashable {
    public let topicTitle: String
    public let topicEmoji: String

    public init(topicTitle: String, topicEmoji: String) {
        self.topicTitle = topicTitle
        self.topicEmoji = topicEmoji
    }
}
