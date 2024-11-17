//
//  TopicRepositoryImpl.swift
//  Data
//
//  Created by 강민성 on 11/3/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

//import Foundation
//import Domain
//
//import RxSwift
//
//struct TopicRepositoryImpl: TopicRepository {
//
//    private let localTopic: any LocalTopicProtocol
////    private let remoteTopic: any RemoteTopicProtocol
//
//    init(localTopic: any LocalTopicProtocol) {
//        self.localTopic = localTopic
//    }
//
//    func fetchTopicList() -> RxSwift.Observable<[Domain.TopicEntity]> {
//        Cache<[TopicEntity]>()
//            .localData { self.localTopic.fetchTopics() }
//            .remoteData { self.remoteTopic.fetchTopics() }
//            .doOnNeedRefresh {
//                self.localTopic.deleteTopics
//                self.localTopic.saveTopic(topics: $0)
//            }
//            .createObservable()
//    }
//    
//    
//}
