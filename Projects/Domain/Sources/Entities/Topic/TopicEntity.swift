//
//  TopicEntity.swift
//  Domain
//
//  Created by 강민성 on 9/22/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

public struct TopicEntity: Equatable {
    public let topicId: Int
    public let topicTitle: String
    public let topicEmoji: String

    public init(topicId: Int, topicTitle: String, topicEmoji: String) {
        self.topicId = topicId
        self.topicTitle = topicTitle
        self.topicEmoji = topicEmoji
    }
}
