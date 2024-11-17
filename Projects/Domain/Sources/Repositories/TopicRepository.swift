//
//  TopicRepository.swift
//  Domain
//
//  Created by 강민성 on 11/3/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import Foundation

import RxSwift

public protocol TopicRepository {
    func fetchTopicList() -> Observable<[TopicEntity]>
}
