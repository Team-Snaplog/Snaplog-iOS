//
//  SnapEntity.swift
//  Domain
//
//  Created by 강민성 on 10/1/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation
import UIKit

public struct SnapEntity: Equatable, Hashable {
    public let snapId: Int
    public let date: Date
    public let body: String?
    public let photos: [UIImage]
    public let topicId: Int

    public init(snapId: Int, date: Date, body: String?, photos: [UIImage], topicId: Int) {
        self.snapId = snapId
        self.date = date
        self.body = body
        self.photos = photos
        self.topicId = topicId
    }
}
